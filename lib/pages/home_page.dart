import 'package:flutter/material.dart';
import 'package:msmchat/manager/account_manager.dart';
import 'package:msmchat/models/user_model.dart';
import 'package:msmchat/pages/chat_page.dart';
import 'package:msmchat/pages/profile_page.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              final user = userList[index];
              return _userItem(user);
            },
          ),
        ),
      ],
    );
  }

  Widget _userItem(UserModel user) {
    return InkWell(
      onTap: () {
        AccountManager.instance.currentUser = user;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
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
