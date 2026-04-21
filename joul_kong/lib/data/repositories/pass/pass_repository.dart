import 'package:joul_kong/models/pass.dart';
import 'package:joul_kong/models/pass_plan.dart';

abstract class PassRepository {
  Future<Pass?> getActivePass(String userId);
  Future<List<PassPlan>> getPassPlans();
  Future<Pass> purchasePass(String userId, PassPlan plan);
}
