import 'dart:io';

import 'package:flutter/material.dart';

class Person {
  final String name;
  final String phone;
  final String chat;
  final File imgFile;
  final DateTime pickDate;
  final TimeOfDay pickTime;

  Person({
    required this.name,
    required this.phone,
    required this.chat,
    required this.imgFile,
    required this.pickDate,
    required this.pickTime,
  });
}

class Profile {
  final String name;
  final String bio;
  final File imgFile;

  Profile({
    required this.name,
    required this.bio,
    required this.imgFile,
  });
}
