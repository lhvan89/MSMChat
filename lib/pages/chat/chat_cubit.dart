import 'package:flutter/cupertino.dart';
import 'package:msmchat/cubit/base_cubit.dart';

import '../../manager/account_manager.dart';
import '../../manager/message_manager.dart';
import '../../models/message_model.dart';
import '../../models/user_model.dart';

class ChatCubit extends BaseCubit {
  UserModel user;

  ChatCubit({required this.user});

  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  bool _canSendMessage() => messageController.text.isNotEmpty;
  UserModel? currentUser = AccountManager.instance.currentUser();

  @override
  void initCubit() {
    super.initCubit();
    getMessages();

    MessageManager.instance.listenNewMessage(
      callback: () {
        if (scrollController.hasClients) {
          if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 200) {
            jumpToBottom();
          }
        }
      },
    );
  }

  void getMessages() async {
    List<String> users = [
      AccountManager.instance.currentUser()?.username ?? '',
      user.username
    ];
    users.sort();
    MessageManager.instance.connectRoom(users.join('_'));
    jumpToBottom();
  }

  Future<bool> sendMessage() async {
    if (_canSendMessage()) {
      final message = MessageModel(currentUser?.username ?? '',
          currentUser?.name ?? '', messageController.text, DateTime.now());
      await MessageManager.instance.saveMessage(message);
      messageController.clear();
      return true;
    }
    return false;
  }

  void jumpToBottom() {
    Future.delayed(const Duration(milliseconds: 300), () {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    messageController.clear();
    super.dispose();
  }
}
