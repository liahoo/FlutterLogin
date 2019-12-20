import 'package:moshi_live/model/User.dart';
import 'package:moshi_live/model/remote/LoginResponse.dart';
import 'package:dio/dio.dart';
import 'package:moshi_live/model/remote/UserResponse.dart';

class ApiProvider {
  static final String _baseUrl = "http://10.253.5.30:8080/API/v1";
  final String _pathLogin = "/Login";
  final String _pathRegister = "/Register";
  final String _pathRegisterToken = "/RegisterToken";
  Dio _dio;
  String _loginToken;

  ApiProvider() {
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
  }

  Future<LoginResponse> login(String email, String password) async {
    try {
      Response response = await _dio.post(_pathLogin, data: {
        "email": email,
        "password": password
      });
      return LoginResponse.fromJson(response.statusCode, response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return LoginResponse.withError(500, error);
    }
  }

  Future<ApiResponse> registerToken(String deviceToken) async {
    try {
      Response response = await _dio.post(_pathRegisterToken, data: {
        "deviceToken": deviceToken,
        "isMaster": false
      });
      if (200 == response.statusCode)
        return ApiResponse(null);
      else {
        return ApiResponse(response.data);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ApiResponse(error);
    }
  }

  bool isLogin() {
    return _loginToken != null;
  }

  void setLoginToken(String loginToken) {
    _loginToken = loginToken;
    _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options) =>
        {
          options.headers.addAll({"Header": loginToken})
        }
    ));
  }

  Future<UserResponse> getUserProfile() async {
    try {
      Response response = await _dio.get("/UserProfile");
      if (200 == response.statusCode) {
        return UserResponse.fromJson(response.data);
      } else {
        return UserResponse.fromJson(response.data);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return UserResponse.withError(error);
    }
  }
}

class ApiResponse {
  final String error;
  ApiResponse(this.error);
}