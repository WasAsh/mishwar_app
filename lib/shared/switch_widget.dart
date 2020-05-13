import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mishwar_app/utils/AppLocalizations.dart';
import 'package:mishwar_app/utils/LocalSettings.dart';

import '../main.dart';
import 'bottom_bar.dart';

class SwitchWidget extends StatefulWidget {
  @override
  SwitchWidgetClass createState() => new SwitchWidgetClass();
}

class SwitchWidgetClass extends State {
  bool switchControl = false;
  var textHolder = 'Language is English';

  void toggleSwitch(bool value) {
    if (switchControl == false) {
      setState(() {
        switchControl = true;
        textHolder = 'Language is English';
        LocalSettings.appLocale = "en";
        LocalSettings().setLocale("en");
        AppLocalizations(Locale("en", 'US'));
        Navigator.pop(context);

//        Navigator.pushAndRemoveUntil(
//            context,
//            MaterialPageRoute(builder: (context) => BottomBar()),
//            ModalRoute.withName("/BottomBar"));
        runApp(MyApp());
      });
      print('Switch is ON');
      // Put your code here which you want to execute on Switch ON event.

    } else {
      setState(() {
        switchControl = false;
        textHolder = 'Language is Arabic';

        LocalSettings.appLocale = "ar";
        LocalSettings().setLocale("ar");
        AppLocalizations(Locale("ar", 'EG'));
        Navigator.pop(context);

//        Navigator.pushAndRemoveUntil(
//            context,
//            MaterialPageRoute(builder: (context) => BottomBar()),
//            ModalRoute.withName("/BottomBar"));
        runApp(MyApp());
      });
      print('Switch is OFF');
      // Put your code here which you want to execute on Switch OFF event.
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (LocalSettings.appLocale != null) {
      if (LocalSettings.appLocale == "en") {
        switchControl = true;
         textHolder = 'Language is English';
      } else {
        switchControl = false;
         textHolder = 'Language is Arabic';
      }
    } else {
      switchControl = true;
       textHolder = 'Language is English';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Transform.scale(
          scale: 1.5,
          child: Switch(
            onChanged: toggleSwitch,
            value: switchControl,
            activeColor: Colors.red,
            activeTrackColor: Colors.red,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey,
          )),
      Text(
        '$textHolder',
        style: TextStyle(fontSize: 24),
      )
    ]);
  }
}
