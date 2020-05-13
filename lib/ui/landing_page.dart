import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mishwar_app/models/shop.dart';
import 'package:mishwar_app/shared/_couponItemRow.dart';
import 'package:mishwar_app/shared/_shopItemRow.dart';
import 'package:mishwar_app/shared/header_image.dart';
import 'package:mishwar_app/shared/nav_drawer.dart';
import 'package:mishwar_app/utils/AppLocalizations.dart';
import 'package:mishwar_app/utils/LocalSettings.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'category_page.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  var messagesFirebaseRef, messagesFirebasemMetaRef;

  bool isSearched = false;
  String searchKey = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    messagesFirebaseRef = FirebaseDatabase().reference().child("shop");
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController _searchController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(240, 240, 240, 1),
        drawer: NavigationDrawer(),
        body: Stack(
          children: <Widget>[
            ListView(
              children: <Widget>[
                HeaderImage(),
                Padding(
                  padding: EdgeInsets.only(
                    left: 18,
                    right: 18,
                  ),
                  child: _buildSearchField()
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "${AppLocalizations.of(context).feeling}",
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 43,
                      color: Color.fromRGBO(141, 141, 141, 1),
                    ),
                  ),
                ),
                isSearched ? buildCouponList(searchKey) : drawMainCategories(),
              ],
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }



  TextEditingController _controller = new TextEditingController();

  Widget _buildSearchField() {
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35.0),
              border: Border.all(color: Colors.black54, width: 2),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 20),
              child: TextField(
                controller: _controller,
                cursorColor: Colors.white,
                onChanged: (value) {
                  searchKey = value;
//                  searchKey = _searchController.value.text.toString();
                  setState(() {
                    if (value.isEmpty) {
                      isSearched = false;
                    } else {
                      isSearched = true;
                    }
                  }); },
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.blueGrey),
                decoration: InputDecoration(
                  hintText: "${AppLocalizations.of(context).Search}",
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black45),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
            child: Icon(Icons.search)
          ),
        ],
      ),
    );
  }



  Widget drawCategory(String title , String type){
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CategoryPage(type: type)));
      },
      title: Text(
        '$title',
        style: TextStyle(
          color: Color.fromRGBO(158, 158, 158, 1),
          fontSize: 16,
        ),
      ),
    );

  }

  Widget drawCategoryPadding(){
    return  Padding(
      padding: EdgeInsets.only(
        left: 18,
        right: 18,
      ),
      child: Container(
        width: double.infinity,
        height: 1,
        color: Colors.grey.shade300,
      ),
    );

  }


  Widget drawMainCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        drawCategory( "Food & Dining" , "1"),
        drawCategoryPadding(),
        drawCategory( "Driving Schools" , "6"),
        drawCategoryPadding(),
        drawCategory( "Gym & Fitness" , "10"),
        drawCategoryPadding(),
        drawCategory( "SuperMarkets" , "12"),
        drawCategoryPadding(),
        drawCategory( "Hair salon & Beauty center" , "14"),
        drawCategoryPadding(),

      ],
    );
  }

  Widget buildCouponList(String searchKeyWord) {
    if (messagesFirebaseRef != null) {
      return StreamBuilder(
        stream: messagesFirebaseRef.onValue,
        builder: (context, snap) {
          print("snap.hasError" + snap.hasError.toString());
          if (snap.hasData &&
              !snap.hasError &&
              snap.data.snapshot.value != null) {
            Map data = snap.data.snapshot.value;
            List<ShopModel> msgs = List<ShopModel>();

            data.forEach((key, values) {
              var chatMsg = ShopModel(
                id: values["id"],
                type: values["type"],

                cityEn: LocalSettings.appLocale == "en" ?values["cityEn"] :values["cityAr"],
                TradeAr: LocalSettings.appLocale == "en" ? values["TradeEn"] :values["TradeAr"] ,
                img: values["img"],
                lat: values["lat"],
                lng: values["lng"],
                rate: values["rate"],
                closeTime: values["closeTime"],
                openTime: values["openTime"],
              );
              String trade=  values["TradeAr"] ;
              if ( trade.contains(searchKey)) {
                msgs.add(chatMsg);
              }
            });
            return
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, position) {
                  return ShopItem(
                      msgs[position].id,
                      msgs[position].TradeAr,
                      msgs[position].cityEn,
                      msgs[position].img,
                      msgs[position].lat,
                      msgs[position].lng,
                      msgs[position].rate,
                      msgs[position].closeTime,
                      msgs[position].openTime);
                },
                itemCount: msgs.length);
          } else {
            return SizedBox();
          }
        },
      );
    } else {
      return SizedBox();
    }
  }
}
