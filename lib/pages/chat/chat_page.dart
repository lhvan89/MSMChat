import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:msmchat/models/user_model.dart';
import 'package:msmchat/pages/base_staless_widget.dart';
import 'package:msmchat/pages/chat/chat_cubit.dart';
import 'package:msmchat/utils/app_color.dart';
import 'package:msmchat/widgets/widgets.dart';

import '../../manager/account_manager.dart';
import '../../manager/message_manager.dart';
import '../../models/message_model.dart';
import '../../utils/utils.dart';

class ChatPage extends BaseStatelessWidget<ChatCubit> {
  String? title;

  ChatPage({Key? key, this.title, required UserModel user})
      : super(key: key, cubit: ChatCubit(user: user));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title?.toUpperCase() ?? ''),
        backgroundColor: AppColor.primaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            _getMessageList(context),
            const Divider(height: 1),
            Container(
              color: Colors.white,
              child: Row(
                children: [
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child:
                    TextFormField(
                      controller: cubit.messageController,
                      maxLines: 5,
                      minLines: 1,
                    )
                  ),
                  IconButton(
                    onPressed: () async {
                      await cubit.sendMessage();
                      cubit.jumpToBottom();
                    },
                    icon: const Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _getMessageList(BuildContext context) {
    return Expanded(
      child: FirebaseAnimatedList(
        controller: cubit.scrollController,
        query: MessageManager.instance.getMessageQuery(),
        itemBuilder: (context, snapshot, animation, index) {
          final json = snapshot.value as Map<dynamic, dynamic>;
          final message = MessageModel.fromJson(json);
          return _messageWidget(context, message,
              message.username == AccountManager.instance.currentUser.username);
        },
      ),
    );
  }

  Widget _messageWidget(
      BuildContext context, MessageModel message, bool isMyMessage) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: isMyMessage
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(width: 70),
                _messageContent(context, message, true),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _avatar(message.name),
                const SizedBox(width: 10),
                _messageContent(context, message, false),
                const SizedBox(width: 70),
              ],
            ),
    );
  }

  Widget _avatar(String fullName) {
    return CircleAvatar(
      backgroundColor: AppColor.primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Text(
          GetAvatarName(fullName).toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _messageContent(
      BuildContext context, MessageModel message, bool isMyMessage) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width - (isMyMessage ? 102 : 153),
      ),
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
          Text(
            message.text,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            convertDateToString(message.date, 'HH:mm'),
            style: const TextStyle(color: Colors.black45, fontSize: 12),
            textAlign: TextAlign.right,
          )
        ],
      ),
    );
  }
}
