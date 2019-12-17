import 'package:moshi_live/model/User.dart';

class LoginResponse {
  final String result;
  final String jwt;
  final User user;
  LoginResponse(this.result, this.jwt, this.user);

  LoginResponse.fromJson(Map<String, dynamic> json) :
    result = json["result"],
    jwt = json["jwt"],
    user = User.fromJson(json["data"]);
}