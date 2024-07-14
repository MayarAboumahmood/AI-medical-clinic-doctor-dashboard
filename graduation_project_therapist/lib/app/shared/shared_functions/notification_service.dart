import 'package:flutter/foundation.dart';
import 'package:pushy_flutter/pushy_flutter.dart';

Future<String> pushyRegister() async {
  try {
    Pushy.setAppId('65f0254743c3630538fe9ee8');
    // Register the user for push notifications
    String deviceToken = await Pushy.register();
    return deviceToken;
    // Display an alert with the device token

    // Optionally send the token to your backend server via an HTTP GET request
    // ...
  } catch (error) {
    // Display an alert with the error message
    if (kDebugMode) {
      print("the error when register the notification by pushy:$error");
    }
    return '';
  }
}
// After the import statements, and outside any Widget class (top-level)

@pragma('vm:entry-point')
void backgroundNotificationListener(Map<String, dynamic> data) {
  // Notification title
  String notificationTitle = data['title'];

  // Attempt to extract the "message" property from the payload: {"message":"Hello World!"}
  String notificationText = data['body'] ?? 'Hello World!';

  // Android: Displays a system notification
  // iOS: Displays an alert dialog
  Pushy.notify(notificationTitle, notificationText, data);

  // Clear iOS app badge number
  Pushy.clearBadge();
}
