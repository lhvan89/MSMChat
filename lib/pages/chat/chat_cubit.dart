import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:msmchat/cubit/base_cubit.dart';
import 'package:msmchat/manager/storage_manager.dart';
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
  BehaviorSubject<bool> isGotNewMessage = BehaviorSubject();
  BehaviorSubject<bool> canSendMessage = BehaviorSubject();
  String urlFile = '';

  UserModel? currentUser = AccountManager.instance.currentUser();

  @override
  void initCubit() {
    super.initCubit();
    getConversation();

    scrollController.addListener(() {
      if (scrollController.position.atEdge &&
          scrollController.position.pixels != 0) {
        isGotNewMessage.sink.add(false);
      }
    });

    MessageManager.instance.listenNewMessage(callback: (event) {
      if (scrollController.hasClients) {
        if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 300) {
          jumpToBottom();
        } else {
          isGotNewMessage.sink.add(true);
        }
      }
    });
  }

  Future<void> pickUpImage() async {
    XFile? xFile = await ImagePicker().pickImage(source: ImageSource.gallery, maxWidth: 1024, maxHeight: 768, imageQuality: 60);
    if (xFile != null) {
      File? file = File(xFile.path);
      await StorageManager.instance.uploadFile(file);
      urlFile = await StorageManager.instance.getDownloadURL(file);
      if (urlFile.isNotEmpty) {
        sendMessage();
      }
    }
  }

  void getConversation() {
    List<String> users = [currentUser?.username ?? '', user.username];
    users.sort();

    MessageManager.instance.connectRoom(users.join('_'));
    Future.delayed(const Duration(seconds: 1), () {
      jumpToBottom();
    });
  }

  void sendMessage() {
    final message = MessageModel(currentUser?.username ?? '',
        currentUser?.name ?? '', messageController.text, DateTime.now(), urlFile);
    MessageManager.instance.saveMessage(message);
    messageController.clear();
    urlFile = '';
    canSendMessage.sink.add(false);
  }

  void validateSendButton(String message) {
    canSendMessage.sink.add(message.trim().isNotEmpty);
  }

  void jumpToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        if (scrollController.position.atEdge &&
            scrollController.position.pixels != 0) {
          isGotNewMessage.sink.add(false);
          return;
        }
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
        jumpToBottom();
      }
    });
  }

  @override
  void dispose() {
    messageController.clear();
    isGotNewMessage.close();
    canSendMessage.close();
    super.dispose();
  }
}
