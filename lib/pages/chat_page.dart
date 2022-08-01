import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../manager/account_manager.dart';
import '../manager/message_manager.dart';
import '../models/message_model.dart';
import '../models/user_model.dart';
import '../utils/utils.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

   TextEditingController _messageController = TextEditingController();
  late ScrollController _scrollController;
  UserModel currentUser = AccountManager.instance.currentUser;

  bool _canSendMessage() => _messageController.text.length > 0;

  @override
  void initState() {
    // TODO: implement initState
    _scrollController = ScrollController();
    MessageManager.instance.getMessageQuery();
    Future.delayed(Duration(seconds: 1), () {
      jumpToBottom();
    });

    super.initState();
  }

  Widget _getMessageList() {
    return Expanded(
      child: FirebaseAnimatedList(
        controller: _scrollController,
        query: MessageManager.instance.getMessageQuery(),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final message = MessageModel.fromJson(json);
          return _messageWidget(message,
              message.username == AccountManager.instance.currentUser.username);
        },
      ),
    );
  }

  Future<bool> _sendMessage() async {
    if (_canSendMessage()) {
      final message = MessageModel(currentUser.username, currentUser.name,
          _messageController.text, DateTime.now());
      await MessageManager.instance.saveMessage(message);
      _messageController.clear();

      return true;
    }
    return false;
  }

  void jumpToBottom() {
    if (_scrollController.hasClients)
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 50),
    );
  }

  @override
  Widget build(BuildContext context) {
    // jumpToBottom();
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: Icon(Icons.arrow_back)),
              Spacer(),
              const Text('CHUYỆN TRÒ LINH TINH'),
              Spacer(),
              SizedBox(width: 32,)
            ],
          ),
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
                      onPressed: () async {
                        await _sendMessage();
                        jumpToBottom();
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
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Image.network(
            'https://ssl.gstatic.com/docs/common/profile/${username}_lg.png'),
      ),
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment:
          isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (isMyMessage == false)
              Text(
                message.name,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
            const SizedBox(height: 8),
            Text(message.text, style: TextStyle(fontSize: 18),),
            const SizedBox(height: 8),
            Text(
              convertDateToString(message.date, 'HH:mm'),
              style: const TextStyle(color: Colors.black45, fontSize: 12),
              textAlign: TextAlign.right,
            )
          ],
        ),
      ),
    );
  }
}
