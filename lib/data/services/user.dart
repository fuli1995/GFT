import 'base_service.dart';

class UserService extends BaseService {
  UserService() {
    super.onInit();
  }

  Future<Map<String, dynamic>> login(Map data) async =>
      (await post('/auth/login', data)).body;

  Future<String?> logout() async => (await post('/staffs/logout', {})).body;
}
