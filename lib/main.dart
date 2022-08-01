import 'package:flutter/material.dart';
import 'package:msmchat/pages/home_page.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ĐĂNG NHẬP')
        ),
        body: HomePage(),
      ),
    );
  }
}