import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  String userEmail = "";
  String userPswd = "";
  int? userId;

  void signIn(String email, String pswd) {
    userEmail = email;
    userPswd = pswd;
  }

  void volunteerId(int id) {
    userId = id;
  }
}
