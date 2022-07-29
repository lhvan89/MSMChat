class MessageModel {
  final String username;
  final String text;
  final DateTime date;

  MessageModel(this.username, this.text, this.date);

  MessageModel.fromJson(Map<dynamic, dynamic> json)
      : username = json['username'] as String,
        date = DateTime.parse(json['date'] as String),
        text = json['text'] as String;

  Map<dynamic, dynamic> toJson() => <dynamic, dynamic>{
    'username': username,
    'date': date.toString(),
    'text': text,
  };
}