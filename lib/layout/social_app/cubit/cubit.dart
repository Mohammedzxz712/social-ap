import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_ap/layout/social_app/cubit/states.dart';
import 'package:social_ap/models/message_model.dart';
import 'package:social_ap/models/post_model.dart';
import 'package:social_ap/models/user_model.dart';
import 'package:social_ap/modules/chats_screen.dart';
import 'package:social_ap/modules/feeds_screen.dart';
import 'package:social_ap/modules/setting_screen.dart';
import 'package:social_ap/modules/users_screen.dart';

import '../../../modules/new_post_screen.dart';
import '../../../shared/components/constants.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;

  void getUser() {
    emit(SocialGetLoadingUserDadaState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data().toString());
      userModel = UserModel.fromJson(value.data()!);
      print('${userModel?.name} ffffffff');
      emit(SocialGetSuccessUserDadaState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetErrorUserDadaState(error.toString()));
    });
  }

  List<Widget> screens = [
    FeedsScreen(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingScreen()
  ];

  List<String> titles = [
    'Home',
    'Chats',
    'Posts',
    'Users',
    'Setting',
  ];
  int currentIndex = 0;

  void changeBottomNav(int index) {
    if (index == 1) {
      getAllUsers();
    }
    if (index == 2) {
      emit(SocialNewPostState());
    } else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;
  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(SocialGetProfileImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialGetProfileImageErrorState());
    }
    ;
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(SocialGetProfileImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialGetProfileImageErrorState());
    }
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialLoadingUpdateUserState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          image: value,
        );
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadProfileImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    emit(SocialLoadingUpdateUserState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        updateUser(
          name: name,
          phone: phone,
          bio: bio,
          cover: value,
        );
      }).catchError((error) {
        print(error.toString());
        emit(SocialUploadCoverImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialUploadCoverImageErrorState());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    UserModel model = UserModel(
      name: name,
      phone: phone,
      bio: bio,
      uId: userModel!.uId,
      image: image ?? userModel!.image,
      cover: cover ?? userModel!.cover,
      email: userModel!.email,
      isEmailVerified: false,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId!)
        .update(model.toMap())
        .then((value) {
      getUser();
    }).catchError((error) {
      print(error.toString());
      emit(SocialUpdateUserErrorState());
    });
  }

  File? postPickedImage;

  void removePostImage() {
    postPickedImage = null;
    emit(SocialRemovePostImageState());
  }

  Future<void> pickedPostImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      postPickedImage = File(pickedFile.path);
      emit(SocialPickedPostImageSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPickedPostImageErrorState());
    }
    ;
  }

  void postUser({
    required String? text,
    String? postImage,
    required String? dateTime,
  }) {
    emit(SocialLoadingPostState());
    PostModel model = PostModel(
      name: userModel!.name,
      uId: userModel!.uId,
      image: userModel!.image,
      dateTime: dateTime,
      postImage: postImage ?? '',
      text: text,
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialPostSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialPostErrorState());
    });
  }

  void postUserImage({
    required String? text,
    required String? dateTime,
  }) {
    emit(SocialLoadingPostImageState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postPickedImage!.path).pathSegments.last}')
        .putFile(postPickedImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        postUser(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
      }).catchError((error) {
        print(error.toString());
        emit(SocialPostImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialPostImageErrorState());
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];

  void getPosts() {
    emit(SocialGetLoadingPostsState());
    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        element.reference.collection('like').get().then((value) {
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          emit(SocialGetSuccessPostsState());
        }).catchError((error) {
          print(error.toString());
        });
        emit(SocialGetSuccessPostsState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetErrorPostsState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('like')
        .doc(userModel?.uId)
        .set({'like': true}).then((value) {
      emit(SocialLikeSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialLikeErrorState(error.toString()));
    });
  }

  List<UserModel> users = [];

  void getAllUsers() {
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId) {
            users.add(UserModel.fromJson(element.data()));
            emit(SocialGetSuccessAllUserDadaState());
          }
        });
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetErrorAllUserDadaState(error.toString()));
      });
    }
  }

  void sendMessage({
    required String? text,
    required String? dateTime,
    required String? receiverId,
  }) {
    MessageModel model = MessageModel(
      text: text,
      dateTime: dateTime,
      senderId: userModel!.uId,
      receiverId: receiverId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialSendMessageErrorState(error));
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
      emit(SocialReceiveMessageSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialReceiveMessageErrorState(error));
    });
  }
}
