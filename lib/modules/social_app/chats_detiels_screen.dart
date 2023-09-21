import 'package:flutter/material.dart';
import 'package:social_ap/layout/social_app/cubit/cubit.dart';

import '../../models/user_model.dart';
import '../../shared/styles/icon_broken.dart';

class ChatsDetailsScreen extends StatelessWidget {
  UserModel model;

  ChatsDetailsScreen({required this.model});

  var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            CircleAvatar(
              radius: 22.0,
              backgroundImage: NetworkImage(
                '${model.image}',
              ),
            ),
            const SizedBox(
              width: 5.0,
            ),
            Text(
              '${model.name}',
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(17.0),
        child: Column(
          children: [
            buildMessage(),
            buildMyMessage(),
            Spacer(),
            Container(
              height: 50,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(
                  15.0,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'write your message',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    child: MaterialButton(
                      color: Colors.blue,
                      onPressed: () {
                        SocialCubit.get(context).sendMessage(
                          text: messageController.text,
                          dateTime: DateTime.now().toString(),
                          receiverId: model.uId,
                        );
                      },
                      minWidth: 1,
                      child: const Icon(
                        IconBroken.Send,
                        size: 18,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildMessage() => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(
                10.0,
              ),
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Text(
            'Hello Mohammed',
          ),
        ),
      );

  Widget buildMyMessage() => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue.withOpacity(
              .2,
            ),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(
                10.0,
              ),
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          padding: EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Text(
            'Hello Ahmed',
          ),
        ),
      );
}
