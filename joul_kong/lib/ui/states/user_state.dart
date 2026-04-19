import 'package:flutter/material.dart';
import 'package:joul_kong/models/user.dart';

class UserState extends ChangeNotifier {
  User _currentUser = User(id: "u1", name: "Demo User");

  User get currentUser => _currentUser;

  void setUser(User user) {
    _currentUser = user;
    notifyListeners();
  }
}
