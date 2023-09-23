import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class LocalNotificationService {
   static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize() {

    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) {
        if(notificationResponse.payload != null){
                var jsonData = json.decode(notificationResponse.payload!);
        }
      },
    );
  }
  //
  static void showNotificationOnForeground(RemoteMessage message) {
    const notificationDetail = NotificationDetails(
        android: AndroidNotificationDetails(
            "com.we2code.nursery",
            "Nursery",
            channelDescription: "firebase push notification",
            importance: Importance.max,
            playSound: true,
            priority: Priority.high));

    _notificationsPlugin.show(
        DateTime.now().microsecond,
        message.notification?.title ?? "1 notification",
        message.notification?.body ?? "You have new notification",
        notificationDetail,
        payload: jsonEncode(message.data));
  }

}