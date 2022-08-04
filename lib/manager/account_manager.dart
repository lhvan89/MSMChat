import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../event_bus/event_bus.dart';
import '../models/user_model.dart';

class AccountManager {
  AccountManager._instance();
  static final AccountManager instance = AccountManager._instance();

  late SharedPreferences sharedPreferences;

  Future initialize() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static DatabaseReference databaseReference = FirebaseDatabase.instance.reference().child('users');
  List<UserModel> listUser = [];
  UserModel? currentUser;

  Future<List<UserModel>> getListAccount() async {
    listUser = [];
    final snapshot = await databaseReference.get();
    if (snapshot?.value != null) {
      final map = snapshot?.value as Map<dynamic, dynamic>;
      map.forEach((key, value) {
        UserModel user = UserModel.fromJson(value);
        listUser.add(user);
      });
      return listUser;
    }
    return [];
  }

  Query getListUser() {
    return databaseReference;
  }

  Future<void> registerUser(UserModel user) async {
    if (user.username.isEmpty || user.name.isEmpty) return;
    await databaseReference.push().set(user.toJson());
    currentUser = user;
  }

  void logIn(UserModel user) {
    currentUser = user;
    eventBus.fire(ReloadUserEvent());
  }

  void logOut() {
    currentUser = null;
    eventBus.fire(ReloadUserEvent());
  }


}
