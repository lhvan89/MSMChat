import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:msmchat/pages/splash/splash_page.dart';
import 'manager/account_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
