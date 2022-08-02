import 'package:flutter/material.dart';
import 'package:msmchat/pages/profile/profile_page.dart';

import 'manager/account_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  AccountManager.instance.currentUser = (AccountManager.instance.userList.toList()..shuffle()).first;
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProfilePage(),
    );
  }
}