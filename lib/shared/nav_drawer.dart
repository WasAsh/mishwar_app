import 'package:flutter/material.dart';
import 'package:mishwar_app/models/nav_drawer.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mishwar_app/shared/switch_widget.dart';
import 'package:mishwar_app/ui/all_category_page.dart';
import 'package:mishwar_app/ui/category_page.dart';
import 'package:mishwar_app/ui/favourite_page.dart';
import 'package:mishwar_app/utils/AppLocalizations.dart';

class NavigationDrawer extends StatefulWidget {
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    List<NavDrawer> _nav = [
      NavDrawer("${AppLocalizations.of(context).Favourite}", () {
        Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => FaavouritePage()));
    }),
      NavDrawer("${AppLocalizations.of(context).Categories}", () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AllCategoriesPage()));
      }),
      NavDrawer("${AppLocalizations.of(context).Contact}", () {}),
      NavDrawer("${AppLocalizations.of(context).About}", () {}),
    ];

    return Drawer(
      child: Container(
        color: Colors.grey.shade300,
        child: Padding(
          padding: const EdgeInsets.only(left: 5, top: 65),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 100, left: 100),
                child: Container(
                  width: 100,
                  height: 60,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.fill,
                        image: ExactAssetImage('assets/img/logo.png')),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SwitchWidget(),
              SizedBox(
                height: 10,
              ),
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemBuilder: (context, position) {
                  return ListTile(
                    title: Text(
                      _nav[position].title,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Container(
                      width: double.infinity,
                      height: 1,
                      color: Colors.grey.shade500,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      _nav[position].destination();
//                      Navigator.push(context,
//                          MaterialPageRoute(builder: (context) {
//                        return _nav[position].destination();
//                      })
//                      );
                    },
                  );
                },
                itemCount: _nav.length,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "${AppLocalizations.of(context).Follow_Mishwar}",
                    style: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Entypo.facebook_with_circle,
                      color: Colors.red.shade700,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Entypo.instagram_with_circle,
                      color: Colors.red.shade700,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Entypo.twitter_with_circle,
                      color: Colors.red.shade700,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, top: 40),
                child: Column(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${AppLocalizations.of(context).Mishwar}",
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Version 1.0',
                        style: TextStyle(
                          color: Colors.grey.shade500,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
