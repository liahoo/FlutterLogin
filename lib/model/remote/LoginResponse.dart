import 'package:moshi_live/model/User.dart';

class LoginResponse {
  final int resultCode;
  final String error;
  final String token;
  final User user;
  LoginResponse(this.resultCode, this.error, this.token, this.user);

  LoginResponse.fromJson(this.resultCode, Map<String, dynamic> json) :
        error = json["error"],
        token = json["token"],
        user = User.fromJson(json["user"]);

  LoginResponse.withError(this.resultCode, this.error) :
        token = null,
        user = null;
}