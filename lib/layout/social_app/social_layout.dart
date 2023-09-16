import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_ap/layout/social_app/cubit/cubit.dart';
import 'package:social_ap/layout/social_app/cubit/states.dart';
import 'package:social_ap/shared/components/components.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit.get(context).model;
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              title: const Text(
                'NewsFeeds',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ),
            body: ConditionalBuilder(
              condition: model != null,
              builder: (context) {
                return Column(
                  children: [
                    if (!model!.isEmailVerified!)
                      Container(
                        height: 50,
                        color: Colors.yellow.withOpacity(.6),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const Icon(Icons.info_outline),
                              const SizedBox(
                                width: 7,
                              ),
                              const Text('please verifies your email'),
                              const Spacer(),
                              TextButton(
                                onPressed: () {
                                  FirebaseAuth.instance.currentUser
                                      ?.sendEmailVerification()
                                      .then((value) {
                                    toastFun(
                                        txt: 'check your email',
                                        state: ToastStates.SUCCESS);
                                  }).catchError((error) {
                                    print(error.toString());
                                  });
                                },
                                child: const Text('send'),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              },
              fallback: (context) =>
                  const Center(child: CircularProgressIndicator()),
            ));
      },
    );
  }
}
