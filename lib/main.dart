import 'dart:convert';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mishwar_app/shared/bottom_bar.dart';
import 'package:mishwar_app/shared/map_widget.dart';
import 'package:mishwar_app/shared/single_category_page.dart';
import 'package:mishwar_app/ui/login_email.dart';
import 'package:mishwar_app/ui/login_page.dart';
import 'package:mishwar_app/ui/root_page.dart';
import 'package:mishwar_app/ui/shop_page.dart';
import 'package:mishwar_app/shared/single_news_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:mishwar_app/utils/AppLocalizations.dart';
import 'package:mishwar_app/utils/LocalSettings.dart';
import 'package:mishwar_app/utils/authentication.dart';

//import 'package:map_view/map_view.dart';
Future main() async {
  LocalSettings _localSettings = LocalSettings();
//  MapView.setApiKey("AIzaSyBICAjtO4reqgnoW1tOlZ2MEgPi9HIS0zg");

  _localSettings.getLocale().then((sharedVal) {
    if (sharedVal == null) {
      _localSettings.setLocale("en");
      LocalSettings.appLocale = "en";
    }
    _localSettings.getUserId();
    _initFirebaseMessaging();
    configLocalNotification();
    runApp(MyApp());
  });
}

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
new FlutterLocalNotificationsPlugin();

void configLocalNotification() {
  var initializationSettingsAndroid =
  new AndroidInitializationSettings('ic_launcher');
  var initializationSettingsIOS = new IOSInitializationSettings();
  var initializationSettings = new InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: onSelectNotification);
}

void showNotification(message) async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
    Platform.isAndroid
        ? 'com.example.mishwar_app'
        : 'com.example.mishwar_app',
    'mishwar_app',
    'mishwar_app',
    playSound: true,
    enableVibration: true,
    importance: Importance.Max,
    priority: Priority.High,
  );
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin.show(0, message['title'].toString(),
      message['body'].toString(), platformChannelSpecifics,
      payload: json.encode(message));
}

Future onSelectNotification(String title) async {
  await global.navigatorKey.currentState.push(MaterialPageRoute(
      builder: (BuildContext context) => BottomBar(
      )));
}

void _initFirebaseMessaging() async {
  if (Platform.isIOS) iOS_Permission();
  if (Platform.isAndroid) {
    _firebaseMessaging.getToken().then((token) {
      print("firebase token: " + token);
      if (Platform.isIOS) {
        String newString = token.replaceAll("-", "");
        newString = newString.replaceAll(":", "");
        newString = newString.replaceAll("_", "");
        print("new ios firebase token: " + newString);
//        LocalSettings.firebaseToken = newString;
      } else {
//        LocalSettings.firebaseToken = token;
      }
    });
  } else {
    getIOSFirebaseToken();
  }

  _firebaseMessaging.configure(
    onMessage: (Map<String, dynamic> message) async {
      print('on message $message');
      showNotification(message['notification']);
    },
//    onBackgroundMessage: myBackgroundMessageHandler,
    onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      global.navigatorKey.currentState.push(MaterialPageRoute(
          builder: (BuildContext context) => BottomBar(
          )));
    },
    onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      global.navigatorKey.currentState.push(MaterialPageRoute(
          builder: (BuildContext context) => BottomBar(
          )));
    },
  );
}

void iOS_Permission() {
  _firebaseMessaging.requestNotificationPermissions(
      IosNotificationSettings(sound: true, badge: true, alert: true));
  _firebaseMessaging.onIosSettingsRegistered
      .listen((IosNotificationSettings settings) {
    print("Settings registered: $settings");
  });
}

Future<void> getIOSFirebaseToken() async {
  const platform = const MethodChannel('getIOSFirebaseToken');
  String firebaseToken;
  try {
    firebaseToken = await platform.invokeMethod('getIOSFirebaseToken');
    print(firebaseToken + '    ios native code');
//    LocalSettings().setFirebaseToken(firebaseToken);
//    LocalSettings.firebaseToken = firebaseToken;
  } on PlatformException catch (e) {
    print("Failed to get data from native : '${e.message}'.");
  }
}

class MyApp extends StatelessWidget {
  Locale getAppLocale() {
    print("get app locale");
    if (LocalSettings.appLocale != null) {
      if (LocalSettings.appLocale == "en") {
        return Locale("en", 'US');
      } else {
        return Locale("ar", 'EG');
      }
    } else {
      return Locale("en", 'US');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('ar', ''),
      ],
      locale: getAppLocale(),
      routes: {
        '/BottomBar': (context) => BottomBar(),
      },
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home:
//      LoginPage(),

      LocalSettings.userId!= null? BottomBar():LoginSignupPage(
        auth:  new Auth(),
        loginCallback: (){
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BottomBar()),
              ModalRoute.withName("/BottomBar"));

        },
      ) ,//BottomBar(),
    );
  }
}

class global {
  static final navigatorKey = new GlobalKey<NavigatorState>();
}

//import 'package:flutter/material.dart';
//import 'package:mishwar_app/shared/bottom_bar.dart';
//import 'package:mishwar_app/ui/landing_page.dart';
//import 'package:mishwar_app/ui/login_page.dart';
//
//
//main(){
//runApp(MishwarApp()) ;
//}
//
//
//class MishwarApp extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      debugShowCheckedModeBanner: false,
//      home: LandingPage(),
//    );
//  }
//}
