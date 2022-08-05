import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:msmchat/cubit/base_cubit.dart';
import 'package:msmchat/manager/account_manager.dart';
import 'package:msmchat/models/user_model.dart';
import 'package:msmchat/widgets/widgets.dart';
import 'package:rxdart/rxdart.dart';
import '../../event_bus/event_bus.dart';

class RegisterAccountCubit extends BaseCubit {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController hoTenController = TextEditingController();
  BehaviorSubject<String> avatarString = BehaviorSubject();

  @override
  void initCubit() {
    super.initCubit();
  }

  void getAvatarName() {
    avatarString.sink.add(GetAvatarName(hoTenController.text));
  }

  Future<void> signUp(BuildContext context) async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty || hoTenController.text.isEmpty) { return; }
    if (await checkUserExisted()) {
      _showMyDialog(context);
    } else {
      final user = UserModel(usernameController.text, passwordController.text, hoTenController.text);
      await AccountManager.instance.registerUser(user);
      eventBus.fire(ReloadUserEvent());
    }
  }

  Future<bool> checkUserExisted() async {
    List<UserModel> listUser = await AccountManager.instance.getListAccount();
    for (var element in listUser) {
      if (element.username.toLowerCase() == usernameController.text.toLowerCase()) {
        return true;
      }
    }
    return false;
  }


  Future<void> _showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('THÔNG BÁO'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Tài khoản đã tồn tại'),
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
    super.dispose();
  }
}