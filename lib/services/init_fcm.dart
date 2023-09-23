import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import '../controller/account_controller.dart';
import '../controller/home_controller.dart';
import 'local_notification_service.dart';
import 'dart:io' show Platform;

class InitFcm{

  Future<void> backgroundHandler(RemoteMessage message) async {
    if (kDebugMode) {
     //
    }
  }

  static final accountActive = StreamController<bool>.broadcast();

  dispose() {
    accountActive.close();
  }

  void initialize() async{
    //if (!(Platform.isAndroid || Platform.isIOS)) {
      return;
    //}
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      return;
      /// User declined or has not accepted permission
    }

    FirebaseMessaging.onBackgroundMessage(backgroundHandler);

    messaging.onTokenRefresh.listen((event) {
      Get.find<AccountLogic>().setFCMToken(token: event);
    });

    messaging.subscribeToTopic("allApp");

    LocalNotificationService.initialize();

    messaging.getInitialMessage().then((event) {
      // terminated state
      if(event != null){
        String data = "${event.data}";

      }
    });

    FirebaseMessaging.onMessage.listen((event) {
      // foreground state
      print("FCM_PUSHED::: I AM Notification has Received");
      Get.find<HomeLogic>().increaseNotificationCount();
      LocalNotificationService.showNotificationOnForeground(event);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      // background state
      String data = "${event.data}";

    });

  }
}