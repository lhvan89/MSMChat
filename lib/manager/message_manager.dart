import 'package:firebase_database/firebase_database.dart';
import '../models/message_model.dart';

class MessageManager {

  MessageManager._instance();
  static final MessageManager instance = MessageManager._instance();

  final DatabaseReference _messagesRef = FirebaseDatabase.instance.reference().child('messages');

  void saveMessage(MessageModel message) {
    _messagesRef.push().set(message.toJson());
  }

  Query getMessageQuery() {
    return _messagesRef;
  }

}