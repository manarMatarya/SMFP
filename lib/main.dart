import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:smfp/routes/routes.dart';
import 'package:smfp/view/screens/main/fb_notifications.dart';
import 'package:smfp/view/screens/splash_screen.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // var initializationSettingsAndroid = AndroidInitializationSettings('ic_notification');
  // var initializationSettingsIOS = IOSInitializationSettings(
  //     requestAlertPermission: true,
  //     requestBadgePermission: true,
  //     requestSoundPermission: true,
  //     onDidReceiveLocalNotification:
  //         (int id, String title, String body, String payload) async {});
  //
  // var initializationSettings = InitializationSettings(android: initializationSettingsAndroid, iOS:initializationSettingsIOS);
  // await flutterLocalNotificationsPlugin.initialize(initializationSettings,
  //     onSelectNotification: (String payload) async {
  //       if (payload != null) {
  //         debugPrint('notification payload: ' + payload);
  //       }
  //     });

  await Firebase.initializeApp().then((value) async {
    await FbNotifications.initNotifications();
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with FbNotifications {
  var fbm = FirebaseMessaging.instance;

  @override
  void initState() {
    fbm.getToken().then((token) {
      print("==============");
      print(token);
      print("==============");
      GetStorage().write('token', token);
    });

    requestNotificationPermissions();
    initializeForegroundNotificationForAndroid();

    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("ar"),
      ],
      locale: const Locale("ar"),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      theme: ThemeData(
        backgroundColor: Colors.white,
        primaryColor: const Color.fromRGBO(3, 149, 72, 1),
      ),
      home: const SplashScreen(), //AppRoutes.login,
      getPages: AppRoutes.routes,
    );
  }
}
