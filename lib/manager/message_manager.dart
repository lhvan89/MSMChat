import 'package:firebase_database/firebase_database.dart';
import '../models/message_model.dart';

class MessageManager {

  MessageManager._instance();
  static final MessageManager instance = MessageManager._instance();

  DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  void connectRoom(String roomCode) {
    _databaseReference = FirebaseDatabase.instance.ref().child('messages/$roomCode');
  }

  Future<void> saveMessage(MessageModel message) async {
    await _databaseReference.push().set(message.toJson());
  }

  Query getQueryMessage() {
    return _databaseReference;
  }

  void listenNewMessage({required Function(DatabaseEvent event) callback}){
    _databaseReference.onValue.listen((event) {
      if(event.previousChildKey == null){
        callback.call(event);
      }
    });
  }
}