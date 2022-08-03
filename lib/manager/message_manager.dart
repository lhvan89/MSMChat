import 'package:firebase_database/firebase_database.dart';
import '../models/message_model.dart';

class MessageManager {

  MessageManager._instance();
  static final MessageManager instance = MessageManager._instance();

  static DatabaseReference databaseReference = FirebaseDatabase.instance.reference();

  void connectRoom(String roomCode) {
    databaseReference = FirebaseDatabase.instance.reference().child('messages/$roomCode');
  }

  Future<void> saveMessage(MessageModel message) async {
    await databaseReference.push().set(message.toJson());
  }

  Query getMessageQuery() {
    return databaseReference;
  }
}