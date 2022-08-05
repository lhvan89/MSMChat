import 'package:flutter/material.dart';
import 'package:msmchat/manager/account_manager.dart';
import 'package:msmchat/pages/login/login_page.dart';
import 'package:msmchat/pages/profile/profile_page.dart';
import '../../event_bus/event_bus.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  @override
  void initState() {
    super.initState();
    checkLogin();
    eventBus.on<ReloadUserEvent>().listen((event) {
      checkLogin();
    });
  }

  void checkLogin() {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Future.delayed(const Duration(milliseconds: 0), () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AccountManager.instance.currentUser() == null ? LoginPage() : ProfilePage(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg_login.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}