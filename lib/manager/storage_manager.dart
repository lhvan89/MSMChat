import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageManager {
  StorageManager._instance();
  static final StorageManager instance = StorageManager._instance();


  Future initialize() async {}

  Future<void> uploadFile(File file) async {
    try {
      await FirebaseStorage.instance.ref().child('images/${file.path.split('/').last}').putFile(file);
    } catch (e){
      print(e);
    }
  }

  Future<String> getDownloadURL(File file) async {
    try {
      return await FirebaseStorage.instance.ref().child('images/${file.path.split('/').last}').getDownloadURL();
    } catch (e) {
      print(e);
      return '';
    }
  }

  Future<void> deleteFile(String fileName) async {
    try {
      await FirebaseStorage.instance.ref().child(fileName).delete();
    } catch (e) {
      print(e);
    }
  }
}