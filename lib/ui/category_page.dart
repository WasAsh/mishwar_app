import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mishwar_app/models/coupon.dart';
import 'package:mishwar_app/models/shop.dart';
import 'package:mishwar_app/shared/_couponItemRow.dart';
import 'package:mishwar_app/shared/_shopItemRow.dart';
import 'package:mishwar_app/shared/header_image.dart';
import 'package:mishwar_app/utils/LocalSettings.dart';

class CategoryPage extends StatefulWidget {
  final String type;

  CategoryPage({this.type, Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  var messagesFirebaseRef, messagesFirebasemMetaRef;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messagesFirebaseRef = FirebaseDatabase().reference().child("shop");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(240, 240, 240, 1),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverFixedExtentList(
              itemExtent: 160,
              delegate: SliverChildListDelegate(
                [
                  HeaderImage(),
                ],
              ),
            ),
            buildCouponList()
          ],
        ),
      ),
    );
  }

  Widget buildCouponList() {
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
              if (widget.type == values["type"]|| widget.type=="0") {
                msgs.add(chatMsg);
              }
            });

            return SliverList(
                delegate: SliverChildBuilderDelegate((context, position) {
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
            }, childCount: msgs.length));
          } else {
            //  sendMessage();
            return SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(),
            ]));
          }
        },
      );
    } else {
      return SliverList(
          delegate: SliverChildListDelegate([
        SizedBox(),
      ]));
    }
  }
}
