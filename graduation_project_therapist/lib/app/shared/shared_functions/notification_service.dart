import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_therapist_dashboard/app/core/constants/app_routs/app_routs.dart';
import 'package:graduation_project_therapist_dashboard/app/features/bottom_navigation_bar/bloc/bottom_navigation_widget_bloc.dart';
import 'package:graduation_project_therapist_dashboard/main.dart';
import 'package:pushy_flutter/pushy_flutter.dart';

Future<String> pushyRegister() async {
  try {
    Pushy.setAppId('668fba9225ac2f637cfcdbc5');
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
  String notificationTitle = data['title'] ?? data['message'];

  // Attempt to extract the "message" property from the payload: {"message":"Hello World!"}
  String notificationText = data['body'] ?? 'Hello World!';
  String notificationType = data['type'] ?? 'no type';

  print('sssssssssssssssssssssssss pushy:$notificationTitle');
  print('sssssssssssssssssssssssss pushy:$notificationText');
  print('sssssssssssssssssssssssss pushy:$notificationType');
  // Android: Displays a system notification
  // iOS: Displays an alert dialog
  if (notificationType == 12) {
    showVideoCallNotification(notificationTitle, notificationText);
    //here show I show the notification of the video
  } else {
    Pushy.notify(notificationTitle, notificationText, data);
  }

  // Clear iOS app badge number
  Pushy.clearBadge();
}

void notificationClickListener(
    BuildContext context, Map<String, dynamic> data) {
  String notificationType = data['type'] ?? 'no type';
  BottomNavigationWidgetBloc bottomNavigationWidgetBloc =
      context.read<BottomNavigationWidgetBloc>();

  /*
Session completed   1
appointment cancelled    2
appointment request     3
appointment time has been set   4
appointment rejected   5
appointment accepted    6
Session is starting soon  7
new login!   8
employment request  9
new employee  10
Assignment  11
—————————-
    const data = {
      type:type,
      title: title,
      body: content,
 }; */
  switch (notificationType) {
    case '5' || '3' || '1':
      navigationService.navigationOfAllPagesToName(
          context, bottomNavigationBar);
      bottomNavigationWidgetBloc.add(ChangeCurrentPage(nextIndex: 2));
      break;
    case '9' || '6' || '7' || '4' || '2':
      navigationService.navigationOfAllPagesToName(
          context, bottomNavigationBar);

      bottomNavigationWidgetBloc.add(ChangeCurrentPage(nextIndex: 3));
      break;
    case '10' || '11':
      navigationService.navigationOfAllPagesToName(
          context, bottomNavigationBar);

      bottomNavigationWidgetBloc.add(ChangeCurrentPage(nextIndex: 1));
      break;

    default:
      print('Unknown notification type: $notificationType');
      break;
  }
}

void showVideoCallNotification(String title, String body) {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 12, // Unique ID f.or the notification
      channelKey: 'video_call_channel',
      title: title,
      body: body,
      notificationLayout: NotificationLayout.Default,
      largeIcon:
          'asset://assets/images/video_call_icon.png', // Your video call icon
      bigPicture:
          'asset://assets/images/video_call_background.png', // Background image
      autoDismissible: false,
      locked: true,
      category: NotificationCategory.Call,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'ACCEPT',
        label: 'Accept',
        color: Colors.green,
        autoDismissible: true,
        actionType: ActionType.Default,
      ),
      NotificationActionButton(
        key: 'DECLINE',
        label: 'Decline',
        color: Colors.red,
        autoDismissible: true,
        actionType: ActionType.Default,
      ),
    ],
  );
}
