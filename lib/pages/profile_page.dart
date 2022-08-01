import 'package:flutter/material.dart';
import 'package:msmchat/manager/account_manager.dart';
import 'package:msmchat/pages/chat_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = AccountManager.instance.currentUser;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back)),
              Spacer(),
              const Text('TÀI KHOẢN'),
              Spacer(),
              SizedBox(width: 32,)
            ],
          ),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              const SizedBox(height: 60),
              CircleAvatar(
                backgroundColor: Colors.green,
                radius: 50,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Image.network(
                      'https://ssl.gstatic.com/docs/common/profile/${currentUser.username}_lg.png'),
                ),
              ),
              const SizedBox(height: 16),
              Text(currentUser.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),),
              const SizedBox(height: 50),
              _buttonStart(context, currentUser.name),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _buttonStart(BuildContext context, String name) {
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatPage()),
              );
            },
            child: Text('VÀO PHÒNG CHAT'),
          ),
        ],
      ),
    );
  }
}
