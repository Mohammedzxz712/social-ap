import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_ap/layout/social_app/cubit/states.dart';
import 'package:social_ap/models/user_model.dart';

import '../../../shared/components/constants.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);
  UserModel? model;

  void getUser() {
    emit(SocialGetLoadingUserDadaState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      print(value.data().toString());
      model = UserModel.fromJson(value.data()!);
      print('${model?.name} ffffffff');
      emit(SocialGetSuccessUserDadaState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetErrorUserDadaState(error.toString()));
    });
  }
}
