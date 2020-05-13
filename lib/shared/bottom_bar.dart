import 'package:flutter/material.dart';
import 'package:mishwar_app/ui/coupons_page.dart';
import 'package:mishwar_app/ui/landing_page.dart';
import 'package:mishwar_app/ui/mishwar_page.dart';
import 'package:mishwar_app/ui/news_page.dart';
import 'package:mishwar_app/ui/shop_page.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:mishwar_app/utils/AppLocalizations.dart';

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {

  final Key keyOne = PageStorageKey('pageOne');
  final Key keyTwo = PageStorageKey('pageTwo');
  final Key keyThree = PageStorageKey('pageThree');
  final Key keyFour = PageStorageKey('pageFour');
  final Key keyFive = PageStorageKey('pageFive');


  int currentTab = 0;

  LandingPage one;
  NewsPage two;
  MishwarPage three ;
  CouponsPage four ;
  ShopPage five ;

  List<Widget> pages;
  Widget currentPage;

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    one = LandingPage(
      key: keyOne,
    );
    two = NewsPage(
      key: keyTwo,
    );
    three = MishwarPage(
      key: keyThree ,
    );
    four = CouponsPage(
      key: keyFour,
    );
    five = ShopPage(
      key: keyFive,
    );

    pages = [one, two , three , four , five];
    currentPage = one;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentPage,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey.shade400,
//        selectedIconTheme: IconThemeData(
//          color: Colors.blueAccent
//        ),
        selectedItemColor: Colors.blueAccent,
        selectedLabelStyle: TextStyle(
          color: Colors.blueAccent
        ),
        type: BottomNavigationBarType.fixed,
        currentIndex: currentTab,
        onTap: (int index){
          setState(() {
            currentTab = index ;
            currentPage = pages[index] ;
          });
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text("${AppLocalizations.of(context).Search}"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Entypo.news ),
            title: Text("${AppLocalizations.of(context).News}" ),
          ),
          BottomNavigationBarItem(
            icon: Tab(
              icon: Image.asset(
                'assets/img/logo.png'
              ),
            ),
            title: Text("${AppLocalizations.of(context).Mishwar}"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Feather.percent),
            title: Text("${AppLocalizations.of(context).Coupons}"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Feather.shopping_bag ),
            title: Text("${AppLocalizations.of(context).Shop}" ),
          ),
        ],
      ),
    );
  }
}
