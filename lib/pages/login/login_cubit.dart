import 'package:flutter/cupertino.dart';
import 'package:msmchat/cubit/base_cubit.dart';
import 'package:msmchat/manager/account_manager.dart';
import 'package:msmchat/models/user_model.dart';
import 'package:msmchat/widgets/widgets.dart';
import 'package:rxdart/rxdart.dart';

class LoginCubit extends BaseCubit {
  TextEditingController usernameController = TextEditingController();
  TextEditingController hoTenController = TextEditingController();
  BehaviorSubject<String> avatarString = BehaviorSubject();

  @override
  void initCubit() {
    super.initCubit();
  }

  void getAvatarName() {
    avatarString.sink.add(GetAvatarName(hoTenController.text));
  }

  void signUp() {
    final user = UserModel(usernameController.text, hoTenController.text);
    AccountManager.instance.saveUser(user);
    AccountManager.instance.currentUser = user;
  }

  void signIn() {
    final user = UserModel(usernameController.text, hoTenController.text);
    AccountManager.instance.currentUser = user;
    AccountManager.instance.saveUser(UserModel(usernameController.text, hoTenController.text));
  }

  @override
  void dispose() {
    usernameController.clear();
    super.dispose();
  }
}