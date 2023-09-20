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
    UserModel model = UserModel(
        name: name,
        email: email,
        uId: uId,
        phone: phone,
        isEmailVerified: false,
        image:
            "https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg",
        bio: 'write your bio...',
        cover:
            'https://img.freepik.com/free-photo/wooden-product-display-podium-with-blurred-nature-leaves-background-generative-ai_91128-2268.jpg?w=996&t=st=1695060690~exp=1695061290~hmac=f90efa2e37818062dda40a32369955b8145b0cb94813a18e52215bba843980d4,');

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
