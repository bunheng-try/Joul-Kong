import 'package:joul_kong/models/pass.dart';

abstract class PassRepository {
  Future<Pass?> getActivePass(String userId);
}
