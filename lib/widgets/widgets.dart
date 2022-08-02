import 'package:flutter/material.dart';

Widget buttonWidget({required String title, required Function() onPressed}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(4),
    child: Stack(
      children: <Widget>[
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF0D47A1),
                  Color(0xFF1976D2),
                  Color(0xFF42A5F5),
                ],
              ),
            ),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(16.0),
            primary: Colors.white,
            textStyle: const TextStyle(fontSize: 20),
          ),
          onPressed: onPressed,
          child: Text(title.toUpperCase()),
        ),
      ],
    ),
  );
}

String GetAvatarName(String fullName) {
  if (fullName.contains(' ')) {
    return fullName.split(' ').first.characters.first + fullName.split(' ').last.characters.first;
  } else {
    return fullName.substring(0,2);
  }
}