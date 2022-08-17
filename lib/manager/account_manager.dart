import 'package:firebase_database/firebase_database.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../event_bus/event_bus.dart';
import '../models/user_model.dart';

class AccountManager {
  AccountManager._instance();
  static final AccountManager instance = AccountManager._instance();

  late SharedPreferences sharedPreferences;
  late DatabaseReference databaseReference;

  Future initialize() async {
    sharedPreferences = await SharedPreferences.getInstance();
    databaseReference = FirebaseDatabase.instance.ref().child('users');
  }

  Future<List<UserModel>> getListAccount() async {
    List<UserModel> listUser = [];
    final snapshot = await databaseReference.get();
    if (snapshot.value != null) {
      final map = snapshot.value as Map<dynamic, dynamic>;
      map.forEach((key, value) {
        UserModel user = UserModel.fromJson(value);
        listUser.add(user);
      });
    }
    return listUser;
  }

  Future<void> registerUser(UserModel user) async {
    if (user.username.isEmpty || user.name.isEmpty) return;
    await databaseReference.push().set(user.toJson());
    logIn(user);
  }

  void logIn(UserModel user) {
    saveUser(user);
    eventBus.fire(ReloadUserEvent());
  }

  void logOut() {
    saveUser(null);
    eventBus.fire(ReloadUserEvent());
  }

  void saveUser(UserModel? user) {
    sharedPreferences.setString('username', user?.username ?? '');
    sharedPreferences.setString('password', user?.password ?? '');
    sharedPreferences.setString('name', user?.name ?? '');
  }

  UserModel? currentUser() {
    String username = sharedPreferences.getString('username') ?? '';
    String password = sharedPreferences.getString('password') ?? '';
    String name = sharedPreferences.getString('name') ?? '';

    if (username.isEmpty || password.isEmpty || name.isEmpty) {
      return null;
    }
    return UserModel(username, password, name);
  }
}