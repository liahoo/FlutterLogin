import 'package:moshi_live/model/remote/UserResponse.dart';
import 'package:moshi_live/repository/UserApiProvider.dart';

class UserRepository {
  UserApiProvider _apiProvider = UserApiProvider();
  Future<UserResponse> getUser() {
    return _apiProvider.getUser();
  }
}