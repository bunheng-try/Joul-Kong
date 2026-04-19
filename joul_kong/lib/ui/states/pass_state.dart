import 'package:flutter/material.dart';
import 'package:joul_kong/models/pass.dart';

class PassState extends ChangeNotifier {
  Pass? _activePass;

  Pass? get activePass => _activePass;

  bool get hasValidPass =>
      _activePass != null && _activePass!.expiryDate.isAfter(DateTime.now());

  void setPass(Pass pass) {
    _activePass = pass;
    notifyListeners();
  }

  void clearPass() {
    _activePass = null;
    notifyListeners();
  }
}
