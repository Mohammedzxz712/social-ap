import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_ap/models/user_model.dart';
import 'package:social_ap/modules/social_app/social_register_screen/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit ge(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) {
    emit(SocialRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      userCreate(
          email: email,
          uId: value.user!.uid,
          name: name,
          phone: phone,
          isEmailVerified: false);
    }).catchError((error) {
      print(error.toString());
      emit(
        SocialRegisterErrorState(
          error.toString(),
        ),
      );
    });
  }

  void userCreate({
    required String email,
    required String uId,
    required String name,
    required String phone,
    required bool isEmailVerified,
  }) {
    UserModel model = UserModel(name, email, uId, phone, isEmailVerified);

    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(
          model.toMap(),
        )
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialCreateUserErrorState(error));
    });
  }

  IconData visible = Icons.visibility_outlined;
  bool obscureText = true;

  void changeVisiblePassword() {
    obscureText = !obscureText;
    obscureText
        ? visible = Icons.visibility_outlined
        : visible = Icons.visibility_off_outlined;
    emit(SocialRegisterChangeVisibilityPasswordState());
  }
}
