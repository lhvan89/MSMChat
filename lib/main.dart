import 'package:flutter/material.dart';
import 'package:msmchat/pages/splash/splash_page.dart';

import 'manager/account_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AccountManager.instance.initialize();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: const MaterialApp(
        home: SplashPage(),
      ),
    );
  }
}
