import 'package:firebase_database/firebase_database.dart';

import '../models/user_model.dart';

class AccountManager {
  AccountManager._instance();

  static final AccountManager instance = AccountManager._instance();

  static DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child('users');

  Query getListUser() {
    return databaseReference;
  }

  Future<void> saveUser(UserModel user) async {
    if (user.username.isEmpty || user.name.isEmpty) return;
    await databaseReference.push().set(user.toJson());
  }

  UserModel currentUser = UserModel('lhvan89', 'Lê Hồng Vấn');
}
