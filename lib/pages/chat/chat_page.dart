import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:msmchat/gen/assets.gen.dart';
import 'package:msmchat/models/user_model.dart';
import 'package:msmchat/pages/base_staless_widget.dart';
import 'package:msmchat/pages/chat/chat_cubit.dart';
import 'package:msmchat/utils/app_color.dart';
import 'package:msmchat/widgets/widget_network_image.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title?.toUpperCase() ?? ''),
        backgroundColor: AppColor.primaryColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  FirebaseAnimatedList(
                    controller: cubit.scrollController,
                    query: MessageManager.instance.getQueryMessage(),
                    itemBuilder: (context, snapshot, animation, index) {
                      final json = snapshot.value as Map<dynamic, dynamic>;
                      final message = MessageModel.fromJson(json);
                      return _messageWidget(context, message);
                    },
                  ),
                  StreamBuilder<bool>(
                    stream: cubit.isGotNewMessage,
                    builder: (context, snapshot) {
                      final isGetNewMessage = snapshot.data ?? false;
                      return isGetNewMessage
                          ? Positioned(
                              child: InkWell(
                                child: const CircleAvatar(
                                  backgroundColor: AppColor.greenActiveColor,
                                  child: Icon(
                                    Icons.arrow_downward,
                                    color: AppColor.whiteColor,
                                  ),
                                ),
                                onTap: () {
                                  cubit.jumpToBottom();
                                },
                              ),
                              bottom: 10,
                              right: 10,
                            )
                          : const SizedBox();
                    },
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Container(
              padding: const EdgeInsets.all(8),
              color: Colors.white,
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      cubit.pickUpImage();
                    },
                    icon: const Icon(
                      Icons.image,
                      color: AppColor.sdtcStartColor,
                    ),
                  ),
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: const BoxDecoration(
                        color: AppColor.disableFieldColor,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: TextFormField(
                      controller: cubit.messageController,
                      maxLines: 5,
                      minLines: 1,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      onChanged: (value) {
                        cubit.validateSendButton(value);
                      },
                    ),
                  )),
                  StreamBuilder<bool>(
                      stream: cubit.canSendMessage,
                      builder: (context, snapshot) {
                        final canSendMessage = snapshot.data ?? false;
                        return IconButton(
                          iconSize: 20,
                          onPressed: () {
                            if (canSendMessage) {
                              cubit.sendMessage();
                            }
                          },
                          icon: Icon(
                            Icons.send,
                            color: canSendMessage ? Colors.blue : Colors.grey,
                            // size: 16,
                          ),
                        );
                      }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _messageWidget(BuildContext context, MessageModel message) {
    final isSend =
        message.username == AccountManager.instance.currentUser()?.username;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        children: [
          if (message.image.isNotEmpty)
          Row(
            mainAxisAlignment:
            isSend ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              RoundedImage(
                url: message.image,
                width: 200,
                height: 200,
                radius: 8,
                fit: BoxFit.cover,
                image: Assets.images.noImage.image(),
                borderWidth: 1,
                borderColor: AppColor.borderGreyColor,
                backgroundColor: Colors.white,
              ),
            ],
          ),
          // if (message.image.isNotEmpty)
          if (message.text.isNotEmpty)
          const SizedBox(height: 16,),
          if (message.text.isNotEmpty)
          Row(
            mainAxisAlignment:
                isSend ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isSend) _avatar(message.name),
              const SizedBox(width: 10),
              _messageContent(context, message, isSend),
            ],
          ),
        ],
      ),
    );
  }

  Widget _avatar(String fullName) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: CircleAvatar(
        backgroundColor: AppColor.primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            GetAvatarName(fullName).toUpperCase(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _messageContent(
      BuildContext context, MessageModel message, bool isSend) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width - (isSend ? 102 : 153),
      ),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8.0)),
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.grey.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment:
            isSend ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          if (isSend == false)
            Text(
              message.name,
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.black54),
            ),
          if (isSend == false) const SizedBox(height: 8),
          Text(
            message.text,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            convertDateToString(
                message.date,
                message.date.day < DateTime.now().day
                    ? 'dd/MM/yy HH:mm'
                    : 'HH:mm'),
            style: const TextStyle(color: Colors.black45, fontSize: 12),
            textAlign: TextAlign.right,
          )
        ],
      ),
    );
  }
}
