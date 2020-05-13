import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mishwar_app/models/coupon.dart';
import 'package:mishwar_app/shared/header_image.dart';
import 'package:mishwar_app/shared/nav_drawer.dart';
import 'package:mishwar_app/utils/LocalSettings.dart';

class CouponsPage extends StatefulWidget {
  CouponsPage({Key key}) : super(key: key);

  @override
  _CouponsPageState createState() => _CouponsPageState();
}

class _CouponsPageState extends State<CouponsPage> {
  var messagesFirebaseRef, messagesFirebasemMetaRef;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messagesFirebaseRef = FirebaseDatabase().reference().child("coupons");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: NavigationDrawer(),
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
            List<CouponModel> msgs = List<CouponModel>();

            data.forEach((key, values) {
              var chatMsg = CouponModel(
                cityAddressAr: LocalSettings.appLocale == "en" ? values["cityAddressEn"]:values["cityAddressAr"],
                couponsTypeAr:  LocalSettings.appLocale == "en" ?values["couponsTypeEn"]:values["couponsTypeAr"],
                shopNameAr: LocalSettings.appLocale == "en" ?values["shopNameEn"]: values["shopNameAr"],
              );
              msgs.add(chatMsg);
            });

            return SliverList(
                delegate: SliverChildBuilderDelegate((context, position) {
              return _couponItemRow(
                  msgs[position].cityAddressAr,
                  msgs[position].shopNameAr,
                  msgs[position].couponsTypeAr,
              );
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

Widget _couponItemRow(
  String cityAddressAr,
  String shopNameAr,
  String couponsTypeAr,
) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            child: Container(
              width: 100,
              height: 60,
             child:  Center(
               child: Text(
                 '$couponsTypeAr OFF',
                 style: TextStyle(
                   fontSize: 18,
                   fontWeight: FontWeight.bold,
                   color: Colors.red
                 ),
               ),
             ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '$shopNameAr',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '$cityAddressAr',
                  style: TextStyle(color: Colors.grey, fontSize: 8),
                ),
                SizedBox(
                  height: 2.5,
                ),
                Text(
                  '$cityAddressAr',
                  style: TextStyle(color: Colors.grey, fontSize: 8),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: RawMaterialButton(
              constraints: BoxConstraints(),
              padding: EdgeInsets.fromLTRB(14, 4, 14, 4),
              elevation: 0,
              onPressed: () {},
              fillColor: Color(0xFFF2F2F2),
              shape: StadiumBorder(),
              child: Text(
                'SHOP',
                style: TextStyle(
                  color: Colors.blueAccent.shade700,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
