import 'package:joul_kong/data/repositories/pass/pass_repository.dart';
import 'package:joul_kong/models/pass.dart';

class MockPassRepository implements PassRepository {
  Pass? _activePass;

  @override
  Future<Pass?> getActivePass(String userId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _activePass;
  }
}
