import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zoft_care/controller/utils/secure_storage.dart';

class AuthRepo {
  Dio client = Dio();
  final storage = const FlutterSecureStorage();

  Future<String> userLogin(String email, String password) async {
    var data = {"email": email, "password": password};
    try {
      final response =
          await client.post("https://mock-api.zoft.care/login", data: data);
      if (response.statusCode == 200 && response.data['status'] == true) {
        print(response.data);
        await SecureStorageRepository()
            .storeValue("token", response.data['data']['accessToken']);

        return response.data['data']['accessToken'];
      }
      return "Error ${response.statusCode.toString()}";
    } catch (e) {
      return "Error ${e.toString()}";
    }
  }

  Future logout() async {
    await SecureStorageRepository().deleteVal('token');
  }
}
