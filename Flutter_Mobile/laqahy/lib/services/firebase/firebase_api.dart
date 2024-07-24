import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:laqahy/services/api/api_exception_widgets.dart';

class FirebaseApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotifications() async {
    try {
      await _firebaseMessaging.requestPermission();
      initPushNotifications();
    } catch (e) {
      ApiExceptionWidgets().mySocketExceptionAlert();
    }
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    // navigatorKey.currentState?.pushNamed(
    //   '/notifications_screen',
    //   arguments: message,
    // );
  }

  Future initPushNotifications() async {
    try {
      FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
      FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    } catch (e) {
      ApiExceptionWidgets().mySocketExceptionAlert();
    }
  }
}
