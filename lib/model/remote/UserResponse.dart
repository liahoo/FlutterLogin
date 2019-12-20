import 'package:moshi_live/apis/UserApiProvider.dart';
import 'package:moshi_live/model/User.dart';

class UserResponse extends ApiResponse{
  final UserProfile user;
  UserResponse(error, this.user): super(error);
  UserResponse.fromJson(Map<String, dynamic> json): user = UserProfile.fromJson(json["data"]), super(json["error"]);
  UserResponse.withError(error): user = null, super(error);
}