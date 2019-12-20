import 'package:moshi_live/apis/UserApiProvider.dart';
import 'package:moshi_live/model/User.dart';
import 'package:moshi_live/model/remote/LoginResponse.dart';
import 'package:moshi_live/model/remote/UserResponse.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc {
  static final String prefKeyLoginToken = "login_token";
  UserProfile _user;
  final ApiProvider _userApi = ApiProvider();
  final BehaviorSubject<UserResponse> _subject = BehaviorSubject<UserResponse>();
  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String _loginToken = prefs.getString(prefKeyLoginToken);
    if(_loginToken!=null) {
      _userApi.setLoginToken(_loginToken);
      _user = await retrieveUserProfile();
    }
  }

  Future<LoginResponse> login(String email, String password) async {
    LoginResponse loginResponse = await _userApi.login(email, password);
    _restoreLoginResponse(loginResponse);
    _userApi.setLoginToken(loginResponse.token);
  }

  bool isLogin() {
    return _userApi.isLogin();
  }

  Future<UserProfile> retrieveUserProfile() async {
    UserResponse response = await _userApi.getUserProfile();
    return response?.user;
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<UserResponse> get subject => _subject;

  Future<ApiResponse> registerToken(String fcmToken) async {
    if(_userApi.isLogin()) {
      return await _userApi.registerToken(fcmToken);
    } else {
      return null;
    }
  }
  void _restoreLoginResponse(LoginResponse loginResponse) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("login_token", loginResponse?.token);
    _user = loginResponse?.user;
  }
}

final userBloc = UserBloc();