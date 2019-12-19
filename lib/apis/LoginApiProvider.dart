import 'dart:ffi';

import 'package:moshi_live/model/remote/LoginResponse.dart';
import 'package:dio/dio.dart';

class LoginApiProvider{
  static final String _endpoint = "http://192.168.11.7:8080/API/v1";
  final String _urlLogin = _endpoint + "/Login";
  final String _urlRegister = _endpoint + "/Register";
  final String _urlRegisterToken = _endpoint + "/RegisterToken";
  String _loginToken;
  final Dio _dio = Dio();

  Future<LoginResponse> login(String email, String password) async {
    try {
      Response response = await _dio.post(_urlLogin, data: {
        "email": email,
        "password": password
      });
      var loginResp =  LoginResponse.fromJson(response.statusCode, response.data);
      restoreLoginToken(loginResp.token);
      return loginResp;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return LoginResponse.withError(500, error);
    }
  }

  Future<SimpleResponse> registerToken(String deviceToken) async {
    try {
      Response response = await _dio.post(_urlRegisterToken, data: {
        "deviceToken": deviceToken
      });
      if(200==response.statusCode)
        return SimpleResponse(null);
      else {
        return SimpleResponse(response.data);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return SimpleResponse(error);
    }
  }

  void restoreLoginToken(String token) {
    _loginToken = token;
  }
}

class SimpleResponse {
  final String error;
  SimpleResponse(this.error);
}