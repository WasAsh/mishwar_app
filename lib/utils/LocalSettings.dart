import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:mishwar_app/models/shop.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalSettings {
  //local settings names
  static const String APP_LOCALE = 'locale';
  static const String USER_ID = 'UserId';

  static String appLocale = "en";
  static String userId = "";

  static const String _TOKEN = 'token';
  static List<ShopModel> favourites = [];


  static String token = "";
  SharedPreferences preferences;

  static final LocalSettings _singleton = LocalSettings._internal();

  factory LocalSettings() {
    return _singleton;
  }

  LocalSettings._internal();

  Future<void> getShared() async {
    preferences = await SharedPreferences.getInstance();
  }

  void setLocale(String localSymbol) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(APP_LOCALE, localSymbol).then((value) {
      appLocale = localSymbol;
    });
  }

  Future<String> getLocale() async {
    preferences = await SharedPreferences.getInstance();
    appLocale = preferences.get(APP_LOCALE);
    return preferences.get(APP_LOCALE);
  }



  void setUserId(String localSymbol) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString(USER_ID, localSymbol).then((value) {
      userId = localSymbol;
    });
  }

  Future<String> getUserId() async {
    preferences = await SharedPreferences.getInstance();
    userId = preferences.get(USER_ID);
    return preferences.get(USER_ID);
  }

  void removeSession() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove(APP_LOCALE);
  }
}
