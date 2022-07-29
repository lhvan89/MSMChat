import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:msmchat/utils/utils.dart';

import 'manager/account_manager.dart';
import 'manager/message_manager.dart';
import 'models/message_model.dart';

void main() => runApp(MainApp());

class MainApp extends StatefulWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  TextEditingController _messageController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  bool _canSendMessage() => _messageController.text.length > 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MessageManager.instance.getMessageQuery();
  }

  Widget _getMessageList() {
    return Expanded(
      child: FirebaseAnimatedList(
        controller: _scrollController,
        query: MessageManager.instance.getMessageQuery(),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final message = MessageModel.fromJson(json);
          // return SizedBox();
          return _messageWidget(message,
              message.username == AccountManager.instance.currentUser.username);
        },
      ),
    );
  }

  void _sendMessage() {
    if (_canSendMessage()) {
      final message = MessageModel(AccountManager.instance.currentUser.username,
          _messageController.text, DateTime.now());
      MessageManager.instance.saveMessage(message);
      _messageController.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Chat'),
        ),
        body: SafeArea(
          child: Column(
            children: [
              _getMessageList(),
              Container(
                color: Colors.white,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        _sendMessage();
                      },
                      icon: const Icon(
                        Icons.send,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _messageWidget(MessageModel message, bool isMyMessage) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: isMyMessage
          ? Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(width: 70),
          _messageContent(message, true),
        ],
      )
          : Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _avatar(message.username),
          const SizedBox(width: 10),
          _messageContent(message, false),
          const SizedBox(width: 70),
        ],
      ),
    );
  }

  Widget _avatar(String username) {
    return CircleAvatar(
      backgroundColor: Colors.green,
      child: Image.network('https://ssl.gstatic.com/docs/common/profile/${username}_lg.png'),
      // child: Image.asset("assets/images/$url.png"),
    );
  }

  Widget _messageContent(MessageModel message, bool isMyMessage) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.grey.withOpacity(0.3)),
        ),
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            if (isMyMessage == false)
              Text(
                message.username,
                style:
                const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            const SizedBox(height: 4),
            Text(message.text),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  convertDateToString(message.date, 'HH:mm'),
                  style: const TextStyle(color: Colors.black45, fontSize: 12),
                )
              ],
            ),
            // Text(message.date.convertToString('dd/MM/yyyy'))
          ],
        ),
      ),
    );
  }
}