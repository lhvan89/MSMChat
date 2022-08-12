import 'package:firebase_database/firebase_database.dart';
import '../models/message_model.dart';

class MessageManager {

  MessageManager._instance();
  static final MessageManager instance = MessageManager._instance();

  late DatabaseReference databaseReference;

  void connectRoom(String roomCode) {
    databaseReference = FirebaseDatabase.instance.reference().child('messages/$roomCode');
  }

  Future<void> saveMessage(MessageModel message) async {
    await databaseReference.push().set(message.toJson());
  }

  void listenNewMessage({required Function(Event event) callback}){
    databaseReference.onValue.listen((event) {
      if(event.previousSiblingKey == null){
        callback.call(event);
      }
    });
  }
}