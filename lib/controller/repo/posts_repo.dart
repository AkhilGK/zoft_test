import 'package:dio/dio.dart';
import 'package:zoft_care/controller/utils/secure_storage.dart';
import 'package:zoft_care/model/posts.dart';

class PostRepo {
  Dio client = Dio();

  Future<PostsResponse> getPost(int size, String tokens) async {
    try {
      print("get posts called");
      String? token = await SecureStorageRepository().getValue("token");
      Response res = await client.get(
          "https://mock-api.zoft.care/posts?page=1&size=$size",
          options: Options(headers: {"x-auth-key": token}));
      if (res.statusCode == 200 && res.data['status'] == true) {
        return PostsResponse.fromJson(res.data);
      }
      return PostsResponse.withError("Error ${res.data['message']}");
    } catch (e) {
      print("get posts called $e");

      return PostsResponse.withError(e.toString());
    }
  }
}
