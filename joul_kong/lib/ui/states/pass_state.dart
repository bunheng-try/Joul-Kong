import 'package:flutter/material.dart';
import 'package:joul_kong/data/repositories/pass/pass_repository.dart';
import 'package:joul_kong/models/pass.dart';
import 'package:joul_kong/models/pass_plan.dart';

class PassState extends ChangeNotifier {
  final PassRepository _repo;

  PassState(this._repo);

  Pass? _activePass;
  List<PassPlan> _plans = [];

  bool _isLoading = false;
  String? _error;

  Pass? get activePass => _activePass;
  List<PassPlan> get plans => _plans;

  bool get isLoading => _isLoading;
  String? get error => _error;

  bool get hasValidPass =>
      _activePass != null && _activePass!.expiryDate.isAfter(DateTime.now());

  Future<void> load(String userId) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _plans = await _repo.getPassPlans();
      _activePass = await _repo.getActivePass(userId);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> selectPass(String userId, PassPlan plan) async {
    if (hasValidPass) {
      _error = "You already have an active pass";
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _activePass = await _repo.purchasePass(userId, plan);
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setPass(Pass pass) {
    _activePass = pass;
    notifyListeners();
  }

  void clearPass() {
    _activePass = null;
    notifyListeners();
  }
}
