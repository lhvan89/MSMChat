import 'package:flutter/material.dart';
import 'package:msmchat/pages/login/login_page.dart';
import 'package:msmchat/pages/register_account/register_account_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}