import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_ap/shared/styles/icon_broken.dart';

import '../layout/social_app/cubit/cubit.dart';
import '../layout/social_app/cubit/states.dart';

class NewPostScreen extends StatelessWidget {
  var textController = TextEditingController();
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back_ios)),
            title: const Text('Create Post'),
            actions: [
              TextButton(
                  onPressed: () {
                    if (SocialCubit.get(context).postPickedImage == null) {
                      SocialCubit.get(context).postUser(
                          text: textController.text, dateTime: now.toString());
                    } else if (SocialCubit.get(context).postPickedImage !=
                        null) {
                      SocialCubit.get(context).postUserImage(
                          text: textController.text, dateTime: now.toString());
                    }
                  },
                  child: const Text('POST')),
              const SizedBox(
                width: 6,
              )
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                if (state is SocialLoadingPostState ||
                    state is SocialLoadingPostImageState)
                  LinearProgressIndicator(),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        'https://image.freepik.com/free-photo/skeptical-woman-has-unsure-questioned-expression-points-fingers-sideways_273609-40770.jpg',
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        'Mohammed Abdullah',
                        style: TextStyle(
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'what is on your mind ...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                if (SocialCubit.get(context).postPickedImage != null)
                  Container(
                    height: 200,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Card(
                            elevation: 5,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Image(
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                  height: 160,
                                  image: FileImage(SocialCubit.get(context)
                                      .postPickedImage!),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 18,
                                    child: IconButton(
                                      onPressed: () {
                                        SocialCubit.get(context)
                                            .removePostImage();
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        size: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).pickedPostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              IconBroken.Image,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'add photo',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          '# tags',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
