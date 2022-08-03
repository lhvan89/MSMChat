class UserModel {
  String username;
  String password;
  String name;

  UserModel(this.username, this.password, this.name);

  factory UserModel.fromJson(Map<dynamic, dynamic> json) {
    return UserModel(
      json['username'] as String,
      json['password'] as String,
      json['name'] as String,
    );
  }

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
        'username': username,
        'password': password,
        'name': name,
      };
}
