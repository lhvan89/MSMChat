import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:msmchat/manager/account_manager.dart';
import 'package:msmchat/models/user_model.dart';
import 'package:msmchat/pages/base_staless_widget.dart';
import 'package:msmchat/pages/chat/chat_page.dart';
import 'package:msmchat/pages/home/home_cubit.dart';
import 'package:msmchat/widgets/widgets.dart';

import '../../manager/message_manager.dart';

class HomePage extends BaseStatelessWidget<HomeCubit> {
  HomePage({Key? key}) : super(key: key, cubit: HomeCubit());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List User'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
              controller: cubit.scrollController,
              query: AccountManager.instance.getListUser(),
              itemBuilder: (context, snapshot, animation, index) {
                final json = snapshot.value as Map<dynamic, dynamic>;
                final user = UserModel.fromJson(json);
                if (user.username ==
                    AccountManager.instance.currentUser.username) {
                  return const SizedBox();
                }
                return _userItem(
                  user: user,
                  onTap: () {
                    List<String> users = [
                      AccountManager.instance.currentUser.username,
                      user.username
                    ];
                    users.sort();
                    MessageManager.instance.connectRoom(users.join('_'));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          title: user.name,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget _userItem({required UserModel user, required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  GetAvatarName(user.name),
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              user.name,
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }
}
