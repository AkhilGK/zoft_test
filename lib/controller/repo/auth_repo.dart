import 'package:dio/dio.dart';

class AuthRepo {
  Dio client = Dio();
  Future<String> userLogin(String email, String password) async {
    var data = {"email": email, "password": password};
    try {
      final response =
          await client.post("https://mock-api.zoft.care/login", data: data);
      if (response.statusCode == 200 && response.data['status'] == true) {
        print(response.data);
        return "success";
      }
      return response.statusCode.toString();
    } catch (e) {
      return e.toString();
    }
  }
}
