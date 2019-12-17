import 'package:moshi_live/model/remote/UserResponse.dart';
import 'package:dio/dio.dart';

class UserApiProvider{
  final String _endpoint = "http://localhost:8080/API/v1";
  final Dio _dio = Dio();

  Future<UserResponse> getUser() async {
    try {
      Response response = await _dio.get(_endpoint);
      return UserResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse(error, null);
    }
  }
}
