import 'package:flutter/cupertino.dart';
import 'package:msmchat/cubit/base_cubit.dart';

import '../../manager/account_manager.dart';
import '../../manager/message_manager.dart';
import '../../models/message_model.dart';
import '../../models/user_model.dart';

class ChatCubit extends BaseCubit {
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();

  bool _canSendMessage() => messageController.text.length > 0;
  UserModel currentUser = AccountManager.instance.currentUser;

  @override
  void initCubit() {
    super.initCubit();

    MessageManager.instance.getMessageQuery();
    Future.delayed(Duration(seconds: 1), () {
      jumpToBottom();
    });
  }

  Future<bool> sendMessage() async {
    if (_canSendMessage()) {
      final message = MessageModel(currentUser.username, currentUser.name,
          messageController.text, DateTime.now());
      await MessageManager.instance.saveMessage(message);
      messageController.clear();
      return true;
    }
    return false;
  }

  void jumpToBottom() {
    if (scrollController.hasClients)
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        curve: Curves.easeOut,
        duration: const Duration(milliseconds: 50),
      );
  }
}
