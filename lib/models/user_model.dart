class UserModel {
  String username;
  String name;

  UserModel(this.username, this.name);

  factory UserModel.alligator() => UserModel('alligator', 'Cá sấu ẩn danh');
  factory UserModel.anteater() => UserModel('anteater', 'Thú ăn kiến ẩn danh');
  factory UserModel.armadillo() => UserModel('armadillo', 'Con Tatu ẩn danh');
  factory UserModel.auroch() => UserModel('auroch', 'Bò rừng ẩn danh');
}