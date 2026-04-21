import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:joul_kong/data/dtos/pass_dto.dart';
import 'package:joul_kong/data/dtos/pass_plan_dto.dart';
import 'package:joul_kong/data/repositories/pass/pass_repository.dart';
import 'package:joul_kong/models/enums.dart';
import 'package:joul_kong/models/pass.dart';
import 'package:joul_kong/models/pass_plan.dart';

class FirebasePassRepository implements PassRepository {
  final String baseUrl;

  FirebasePassRepository(this.baseUrl);

  @override
  Future<List<PassPlan>> getPassPlans() async {
    final url = Uri.parse('$baseUrl/passPlans.json');

    final res = await http.get(url);

    final data = jsonDecode(res.body);

    if (data == null) return [];

    final Map<String, dynamic> map = data;

    return map.entries
        .map((e) => PassPlanDto.fromJson(e.key, e.value).toDomain())
        .toList();
  }

  @override
  Future<Pass?> getActivePass(String userId) async {
    final url = Uri.parse('$baseUrl/passes.json');

    final res = await http.get(url);

    final data = jsonDecode(res.body);

    if (data == null) return null;

    final Map<String, dynamic> map = data;

    for (final entry in map.entries) {
      final dto = PassDto.fromJson(entry.key, entry.value);

      if (dto.userId == userId && dto.status == 'active') {
        return dto.toDomain();
      }
    }

    return null;
  }

  @override
  Future<Pass> purchasePass(String userId, PassPlan plan) async {
    final now = DateTime.now();
    final expiry = now.add(Duration(hours: plan.durationHours));

    final dto = PassDto(
      id: '',
      userId: userId,
      planId: plan.id,
      startDate: now.toIso8601String(),
      expiryDate: expiry.toIso8601String(),
      status: 'active',
    );

    final url = Uri.parse('$baseUrl/passes.json');

    final res = await http.post(url, body: jsonEncode(dto.toJson()));

    final data = jsonDecode(res.body);

    return Pass(
      id: data['name'],
      userId: userId,
      planId: plan.id,
      startDate: now,
      expiryDate: expiry,
      status: PassStatus.active,
    );
  }
}
