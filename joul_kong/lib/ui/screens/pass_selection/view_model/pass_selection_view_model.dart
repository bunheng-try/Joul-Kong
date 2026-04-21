import 'package:flutter/material.dart';
import 'package:joul_kong/data/repositories/pass/pass_repository.dart';
import 'package:joul_kong/models/pass.dart';
import 'package:joul_kong/models/pass_plan.dart';
import 'package:joul_kong/ui/states/pass_state.dart';

class PassViewModel extends ChangeNotifier {
  final PassRepository repo;
  final String userId;
  final PassState passState;

  PassViewModel({
    required this.repo,
    required this.userId,
    required this.passState,
  }) {
    loadData(userId);
  }

  List<PassPlan> _plans = [];
  Pass? _activePass;

  bool _isLoading = false;
  String? _error;

  List<PassPlan> get plans => _plans;
  Pass? get activePass => _activePass;

  bool get isLoading => _isLoading;
  String? get error => _error;

  bool get hasValidPass =>
      _activePass != null && _activePass!.expiryDate.isAfter(DateTime.now());

  Future<void> loadData(String userId) async {
    try {
      _setLoading(true);

      final plansFuture = repo.getPassPlans();
      final activeFuture = repo.getActivePass(userId);

      _plans = await plansFuture;
      _activePass = await activeFuture;

      _error = null;
    } catch (e) {
      _error = e.toString();
      _plans = [];
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> selectPass(PassPlan plan) async {
    if (hasValidPass) {
      _error = "You already have an active pass";
      notifyListeners();
      return false;
    }

    try {
      _setLoading(true);

      final pass = await repo.purchasePass(userId, plan);

      _activePass = pass;

      passState.setPass(pass);

      _error = null;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool v) {
    _isLoading = v;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}
