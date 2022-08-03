import 'package:flutter/material.dart';

String GetAvatarName(String fullName) {
  if (fullName.isEmpty) return '';
  if (fullName.contains(' ')) {
    return fullName.split(' ').first.characters.first + fullName.split(' ').last.characters.first;
  } else {
    return fullName.substring(0,2);
  }
}