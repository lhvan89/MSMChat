import '../models/user_model.dart';

class AccountManager {
  AccountManager._instance();
  static final AccountManager instance = AccountManager._instance();

  UserModel currentUser = UserModel.anteater();
}