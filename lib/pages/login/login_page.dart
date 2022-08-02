import 'package:flutter/material.dart';
import 'package:msmchat/pages/base_staless_widget.dart';
import 'package:msmchat/pages/login/login_cubit.dart';
import 'package:msmchat/pages/profile/profile_page.dart';
import 'package:msmchat/widgets/widgets.dart';

class LoginPage extends BaseStatelessWidget<LoginCubit> {
  LoginPage({Key? key}) : super(key: key, cubit: LoginCubit());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundColor: Colors.green,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: StreamBuilder<String>(
                  stream: cubit.avatarString,
                  builder: (context, snapshot) {
                    final avatarStirng = snapshot.data ?? '';
                    return Text(
                      avatarStirng.toUpperCase(),
                      style: const TextStyle(fontSize: 50),
                    );
                  }),
            ),
          ),
          const SizedBox(height: 32),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 32),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            padding: const EdgeInsets.all(32),
            child: Column(
              children: [
                const SizedBox(height: 16),
                TextField(
                  controller: cubit.usernameController..text = 'lhvan89',
                  decoration: const InputDecoration(
                    hintText: 'username',
                    labelText: 'Username',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(8),
                  ),
                  style: const TextStyle(fontSize: 18),
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 32),
                TextField(
                  controller: cubit.hoTenController..text = 'Lê Hồng Vấn',
                  decoration: const InputDecoration(
                      hintText: 'full name',
                      labelText: 'Full name',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(8)),
                  style: const TextStyle(fontSize: 18),
                  onSubmitted: (text) {
                    cubit.getAvatarName();
                  },
                ),
                const SizedBox(height: 40),
                buttonWidget(
                  title: 'ĐĂNG NHẬP',
                  onPressed: () {
                    cubit.signUp();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
