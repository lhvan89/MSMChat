import 'package:flutter/material.dart';
import 'package:msmchat/event_bus/event_bus.dart';
import 'package:msmchat/manager/account_manager.dart';
import 'package:msmchat/models/user_model.dart';
import 'package:msmchat/pages/home/home_page.dart';
import 'package:msmchat/pages/profile/profile_cubit.dart';
import 'package:msmchat/utils/app_color.dart';
import 'package:msmchat/widgets/widgets.dart';

import '../../manager/storage_manager.dart';
import '../base_staless_widget.dart';

class ProfilePage extends BaseStatelessWidget<ProfileCubit> {
  ProfilePage({Key? key, UserModel? currentUser})
      : super(key: key, cubit: ProfileCubit());

  @override
  Widget build(BuildContext context) {
    final currentUser = AccountManager.instance.currentUser();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('PROFILE'),
        backgroundColor: AppColor.primaryColor,
        actions: [
          InkWell(
            onTap: () {
              AccountManager.instance.logOut();
            },
            child: Icon(Icons.logout, color: Colors.white),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Column(
          children: [
            const SizedBox(height: 32),
            CircleAvatar(
              backgroundColor: AppColor.primaryColor,
              radius: 50,
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  GetAvatarName(currentUser?.name ?? ''),
                  style: const TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              currentUser?.name.toUpperCase() ?? '',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54),
            ),
            const SizedBox(height: 40),
            _button(
              context: context,
              title: 'HOME PAGE',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _button(
      {required BuildContext context,
      required String title,
      required Function() onPressed}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF0D47A1),
                    Color(0xFF1976D2),
                    Color(0xFF42A5F5),
                  ],
                ),
              ),
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(16.0),
              primary: Colors.white,
              textStyle: const TextStyle(fontSize: 20),
            ),
            onPressed: onPressed,
            child: Text(title.toUpperCase()),
          ),
        ],
      ),
    );
  }
}
