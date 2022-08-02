import 'package:flutter/material.dart';
import 'package:msmchat/models/user_model.dart';
import 'package:msmchat/pages/login/login_page.dart';
import 'package:msmchat/manager/account_manager.dart';
import 'package:msmchat/pages/home/home_page.dart';
import 'package:msmchat/pages/profile/profile_cubit.dart';

import '../base_staless_widget.dart';

class ProfilePage extends BaseStatelessWidget<ProfileCubit> {
  ProfilePage({Key? key}) : super(key: key, cubit: ProfileCubit());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TÀI KHOẢN'),
      ),
      body: StreamBuilder<UserModel>(
        stream: cubit.userStream,
        builder: (context, snapshot) {
          final user = snapshot.data;
          return Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                const SizedBox(height: 24),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      SizedBox(width: 24),
                      Text('Chọn user khác', style: TextStyle(fontSize: 17, color: Colors.green)),
                      SizedBox(width: 4),
                      Icon(Icons.change_circle, color: Colors.green),
                      SizedBox(width: 24),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                if (user != null)
                CircleAvatar(
                  backgroundColor: Colors.green,
                  radius: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Image.network(
                        'https://ssl.gstatic.com/docs/common/profile/${user.username}_lg.png'),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  user?.name ?? '',
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
                const SizedBox(height: 40),
                _button(
                    context: context,
                    title: 'ĐĂNG NHẬP',
                    onPressed: () {
                      // List<String> users = [
                      //   AccountManager.instance.currentUser.username,
                      //   currentUser.username
                      // ];
                      // users.sort();
                      // MessageManager.instance.connectRoom(users.join('_'));
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => ChatPage()),
                      // );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    }),
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _button(
      {required BuildContext context,
      required String title,
      required Function() onPressed}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ],
                ),
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(16.0),
              primary: Colors.white,
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: onPressed,
            child: Text(title.toUpperCase()),
          ),
        ],
      ),
    );
  }
}
