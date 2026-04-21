import 'package:joul_kong/data/data_sources/mock/mock_data.dart';
import 'package:joul_kong/data/repositories/pass/pass_repository.dart';
import 'package:joul_kong/models/pass.dart';
import 'package:joul_kong/models/enums.dart';
import 'package:joul_kong/models/pass_plan.dart';

class MockPassRepository implements PassRepository {
  Pass? _activePass;

  @override
  Future<Pass?> getActivePass(String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));

    if (_activePass == null) return null;

    if (_activePass!.expiryDate.isBefore(DateTime.now())) {
      _activePass = null;
      return null;
    }

    return _activePass;
  }

  @override
  Future<List<PassPlan>> getPassPlans() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return MockData.passPlans;
  }

  @override
  Future<Pass> purchasePass(String userId, PassPlan plan) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (_activePass != null &&
        _activePass!.expiryDate.isAfter(DateTime.now())) {
      throw Exception("User already has an active pass");
    }

    final now = DateTime.now();
    final expiry = now.add(Duration(hours: plan.durationHours));

    final newPass = Pass(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: userId,
      planId: plan.id,
      startDate: now,
      expiryDate: expiry,
      status: PassStatus.active,
    );

    _activePass = newPass;

    return newPass;
  }
}
