import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:moshi_live/apis/UserApiProvider.dart';
import 'package:moshi_live/bloc/UserBloc.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

  // Or do other work.
}

class FCMHelper {
  final FirebaseMessaging _fcm = FirebaseMessaging();
  init() {
    _fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage: $message");
        },
        onBackgroundMessage: myBackgroundMessageHandler,
        onLaunch: (Map<String, dynamic> message) async {
          print("onLaunch: $message");
        },
        onResume: (Map<String, dynamic> message) async {
          print("onResume: $message");
        });

    if (_fcm.requestNotificationPermissions()) {}
  }
  Future<ApiResponse> registerDeviceToken() async {
    // Get the current user
    // FirebaseUser user = await _auth.currentUser();

    // Get the token for this device
    String fcmToken = await _fcm.getToken();

    return await userBloc.registerToken(fcmToken);
  }

  Future<void> _handleNotification (Map<dynamic, dynamic> message, bool dialog) async {
    var data = message['data'] ?? message;
    String expectedAttribute = data['expectedAttribute'];
    /// [...]
  }
}

final _fcmHelper = FCMHelper();
