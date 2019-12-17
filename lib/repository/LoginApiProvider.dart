import 'package:moshi_live/model/remote/LoginResponse.dart';
import 'package:dio/dio.dart';

class LoginApiProvider{
  final String _endpoint = "http://localhost:8080/API/v1";
  final Dio _dio = Dio();

  Future<LoginResponse> getUser() async {
    try {
      Response response = await _dio.get(_endpoint);
      return LoginResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return LoginResponse(error, null, null);
    }
  }
}
