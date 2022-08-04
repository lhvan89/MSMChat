import 'package:flutter/material.dart';
import 'package:msmchat/cubit/base_cubit.dart';
import 'package:msmchat/manager/account_manager.dart';
import 'package:msmchat/models/user_model.dart';

class LoginCubit extends BaseCubit {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void initCubit() {
    super.initCubit();
  }

  void getListUser() {
    AccountManager.instance.getListUser();
  }

  Future<bool> checkLogin() async {
    List<UserModel> listUser = await AccountManager.instance.getListAccount();
    for (var user in listUser) {
      if (user.username == usernameController.text && user.password == passwordController.text) {
        AccountManager.instance.logIn(user);
        return true;
      }
    }
    return false;
  }

  void logIn(BuildContext context) async {
    if (await checkLogin()) {
    } else {
      _showDialog(context);
    }
  }

  Future<void> _showDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('THÔNG BÁO'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Username hoặc mật khẩu không đúng'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ĐÓNG'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    usernameController.clear();
    passwordController.clear();
    super.dispose();
  }
}