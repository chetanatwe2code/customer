import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:indiakinursery/theme/dark_theme.dart';
import 'package:indiakinursery/theme/light_theme.dart';

import 'core/language.dart';
import 'core/routes.dart';
import 'core/di/get_di.dart' as di;
import 'dart:io' show Platform;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  await di.init();
  await init();
  runApp(const MyApp());
}


init() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // if (Platform.isAndroid || Platform.isIOS) {
  //   await Firebase.initializeApp();
  // }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static final navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) => GetMaterialApp(
        getPages: Routes.routes,
        translations: Messages(),
        defaultTransition: Transition.leftToRightWithFade,
        //locale: const Locale('hi', 'IN'),
        locale: const Locale('en', 'US'),
        fallbackLocale: const Locale('en', 'UK'),
        initialRoute: rsDefaultPage,
        title: "nursery",
        theme: light(),
        darkTheme: dark(),
      ),
    );
  }
}