import 'package:moshi_live/model/remote/LoginResponse.dart';
import 'package:dio/dio.dart';

class LoginApiProvider{
  final String _endpoint = "http://localhost:8080/API/v1";
  final Dio _dio = Dio();

  Future<LoginResponse> login(String email, String password) async {
    try {
      Response response = await _dio.post(_endpoint, data: {
        "email": email,
        "password": password
      });
      return LoginResponse.fromJson(response.statusCode, response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return LoginResponse.withError(500, error);
    }
  }
}
