import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'Favourite': 'Favourite',
      'Categories': 'Categories ',
      'Contact': 'Contact Us',
      'About': 'About Us',
      'Follow_Mishwar': 'Follow Mishwar',
      'Version': 'Version    ',
      'Mishwar': 'Mishwar app ',
      'feeling': 'What are you feeling today ?',
      'Search': 'Search ',
      'News': ' News',
      'Mishwar': "Mishwar",
      'Coupons': 'Coupons ',
      'Shop': 'Shop ',
    },
    'ar': {
      'Favourite': 'المفضلات',
      'Categories': 'النصميفات ',
      'Contact': 'اتصل بنا',
      'About': 'عننا',
      'Follow_Mishwar': 'تابع مشوار',
      'Version': 'نسخه    ',
      'Mishwar': 'مشوار ',
      'feeling': 'ما شعورك اليوم ؟',
      'Search': 'بحث ',
      'News': ' الاخبار',
      'Mishwar': "مشوار",
      'Coupons': 'كوبونات ',
      'Shop': 'محل ',

    },
  };

  String get Favourite {
    return _localizedValues[locale.languageCode]['Favourite'];
  }


  String get appName {
    return _localizedValues[locale.languageCode]['appName'];
  }

  String get appNameShort {
    return _localizedValues[locale.languageCode]['appNameShort'];
  }

  String get Categories {
    return _localizedValues[locale.languageCode]['Categories'];
  }

  String get Contact {
    return _localizedValues[locale.languageCode]['Contact'];
  }


  String get About {
    return _localizedValues[locale.languageCode]['About'];
  }

  String get Follow_Mishwar {
    return _localizedValues[locale.languageCode]['Follow_Mishwar'];
  }

  String get Mishwar {
    return _localizedValues[locale.languageCode]['Mishwar'];
  }

  String get feeling {
    return _localizedValues[locale.languageCode]['feeling'];
  }

  String get Search {
    return _localizedValues[locale.languageCode]['Search'];
  }

  String get News {
    return _localizedValues[locale.languageCode]['News'];
  }

  String get Coupons {
    return _localizedValues[locale.languageCode]['Coupons'];
  }

  String get Shop {
    return _localizedValues[locale.languageCode]['Shop'];
  }



}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
