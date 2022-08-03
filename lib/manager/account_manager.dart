import 'package:firebase_database/firebase_database.dart';

import '../models/user_model.dart';

class AccountManager {
  AccountManager._instance();

  static final AccountManager instance = AccountManager._instance();

  static DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child('users');
  List<UserModel> listUser = [];
  UserModel currentUser = UserModel('', '', '');

  Future<void> getListAccount() async {
    listUser = [];
    final snapshot = await databaseReference.get();
    if (snapshot?.value != null) {
      print((snapshot?.value).toString());
      final map = snapshot?.value as Map<dynamic, dynamic>;

      // print(snapshot);
      map.forEach((key, value) {
        UserModel user = UserModel.fromJson(value);
        listUser.add(user);
        print(user.username);
      });
    }


  }

  Query getListUser() {
    return databaseReference;
  }

  Future<void> registerUser(UserModel user) async {
    if (user.username.isEmpty || user.name.isEmpty) return;
    await databaseReference.push().set(user.toJson());
    // currentUser = user;
  }


}
