import 'package:flutter/material.dart';
import 'package:msmchat/manager/account_manager.dart';
import 'package:msmchat/models/user_model.dart';
import 'package:msmchat/pages/base_staless_widget.dart';
import 'package:msmchat/pages/login/login_cubit.dart';

import '../../event_bus/event_bus.dart';

class LoginPage extends BaseStatelessWidget<LoginCubit> {
  LoginPage({Key? key}) : super(key: key, cubit: LoginCubit());

  @override
  Widget build(BuildContext context) {
    final userList = AccountManager.instance.userList;
    return Scaffold(
      appBar: AppBar(
        title: const Text('CHỌN USER ĐỂ ĐĂNG NHẬP'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                final user = userList[index];
                return _userItem(context, user);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _userItem(BuildContext context, UserModel user) {
    return InkWell(
      onTap: () {
        AccountManager.instance.currentUser = user;
        eventBus.fire(ReloadUserEvent());
        Navigator.pop(context);
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
