class UserModel {
  String username;
  String name;

  UserModel(this.username, this.name);

  UserModel.fromJson(Map<dynamic, dynamic> json)
      : username = json['username'] as String,
        name = json['name'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'username': username,
    'name': name,
  };
}