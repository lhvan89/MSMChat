import 'package:flutter/material.dart';
import 'package:msmchat/manager/account_manager.dart';
import 'package:msmchat/models/user_model.dart';
import 'package:msmchat/pages/chat/chat_page.dart';

import '../../manager/message_manager.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  late UserModel currentUser;

  Widget build(BuildContext context) {
    final userList = AccountManager.instance.userList;
    return Scaffold(
      appBar: AppBar(
        title: Text('CHỌN USER ĐỂ CHAT'),
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          final user = userList[index];
          if (user.username == AccountManager.instance.currentUser.username) return const SizedBox();
          return _userItem(user);
        },
      )
    );
  }

  Widget _userItem(UserModel user) {
    return InkWell(
      onTap: () {
        List<String> users = [
          AccountManager.instance.currentUser.username,
          user.username
        ];
        users.sort();
        MessageManager.instance.connectRoom(users.join('_'));
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ChatPage(title: user.name,)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.green,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Image.network(
                    'https://ssl.gstatic.com/docs/common/profile/${user.username}_lg.png'),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              user.name,
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            )
          ],
        ),
      ),
    );
  }


}
