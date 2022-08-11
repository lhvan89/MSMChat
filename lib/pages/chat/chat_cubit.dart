import 'package:flutter/cupertino.dart';
import 'package:msmchat/cubit/base_cubit.dart';
import 'package:rxdart/rxdart.dart';

import '../../manager/account_manager.dart';
import '../../manager/message_manager.dart';
import '../../models/message_model.dart';
import '../../models/user_model.dart';

class ChatCubit extends BaseCubit {
  UserModel user;

  ChatCubit({required this.user});

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  BehaviorSubject<List<MessageModel>> listMessageStream = BehaviorSubject();
  BehaviorSubject<bool> isGotNewMessage = BehaviorSubject();

  bool _canSendMessage() => messageController.text.isNotEmpty;
  UserModel? currentUser = AccountManager.instance.currentUser();

  @override
  void initCubit()  {
    super.initCubit();
    getConversation();
    scrollController.addListener(() {
      if(scrollController.position.atEdge && scrollController.position.pixels != 0) {
        isGotNewMessage.sink.add(false);
      }
    });
  }

  void getConversation() {
    List<String> users = [
      currentUser?.username ?? '',
      user.username
    ];
    users.sort();

    MessageManager.instance.connectRoom(users.join('_'));
    getFirebaseMessages();
    Future.delayed(const Duration(milliseconds: 500), () {
        jumpToBottom();
    });
  }

  void getFirebaseMessages() {
    MessageManager.instance.databaseReference.onValue.listen((event) {
      if(event.previousSiblingKey == null){
        List<MessageModel> listMessage = [];
        final map = event.snapshot.value as Map<dynamic, dynamic>;
        map.forEach((key, value) {
          MessageModel message = MessageModel.fromJson(value);
          listMessage.add(message);
        });
        listMessageStream.sink.add(listMessage);
        Future.delayed(const Duration(milliseconds: 300), () {
          if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 300) {
            jumpToBottom();
          } else {
            isGotNewMessage.sink.add(true);
          }
        });
      }
    });
  }

  Future<bool> sendMessage() async {
    if (_canSendMessage()) {
      final message = MessageModel(currentUser?.username ?? '',
          currentUser?.name ?? '', messageController.text, DateTime.now());
      await MessageManager.instance.saveMessage(message);
      messageController.clear();
      return true;
    } else {
      jumpToBottom();
    }
    return false;
  }

  void jumpToBottom() {
    if (scrollController.hasClients) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
      isGotNewMessage.sink.add(false);
    }
  }

  @override
  void dispose() {
    messageController.clear();
    isGotNewMessage.close();
    super.dispose();
  }
}
