import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageManager {
  StorageManager._instance();
  static final StorageManager instance = StorageManager._instance();

  final Reference _storageReference = FirebaseStorage.instance.ref().child('images/');

  Future initialize() async {}

  Future<String> uploadFile(File file) async {
    final fileName = file.path.split('/').last;
    try {
      await _storageReference.child(fileName).putFile(file);
      return await _storageReference.child(fileName).getDownloadURL();
    } catch (e){
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