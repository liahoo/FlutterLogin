import 'package:moshi_live/apis/UserApiProvider.dart';
import 'package:moshi_live/model/User.dart';

class LoginResponse extends ApiResponse {
  final int resultCode;
  final String token;
  final UserProfile user;
  LoginResponse(this.resultCode, error, this.token, this.user) : super(error);

  LoginResponse.fromJson(this.resultCode, Map<String, dynamic> json) :
        token = json["token"],
        user = UserProfile.fromJson(json["user"]),
        super(json["error"]);

  LoginResponse.withError(this.resultCode, error) :
        token = null,
        user = null,
        super(error);
}