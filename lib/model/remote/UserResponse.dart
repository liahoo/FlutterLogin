import 'package:moshi_live/model/User.dart';

class UserResponse {
  final String result;
  final User user;
  UserResponse(this.result, this.user);

  UserResponse.fromJson(Map<String, dynamic> json) :
    result = json["result"],
    user = User.fromJson(json["data"]);

}