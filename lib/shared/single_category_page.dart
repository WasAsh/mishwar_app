import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mishwar_app/models/shop.dart';
import 'package:mishwar_app/shared/header_image.dart';
import 'package:mishwar_app/utils/LocalSettings.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'map_widget.dart';
import 'nav_drawer.dart';

class SingleCategoryPage extends StatefulWidget {
  int id;
  String cityAddressEn;
  String couponsTypeAr;
  String img;
  String lat;
  String lng;
  String rate ;
  String closeTime ;
  String openTime ;

  SingleCategoryPage( this.id, this.cityAddressEn, this.couponsTypeAr, this.img,
      this.lat, this.lng , this.rate , this.closeTime, this.openTime);

  @override
  _SingleCategoryPageState createState() => _SingleCategoryPageState(this.id, this.cityAddressEn, this.couponsTypeAr, this.img,
      this.lat, this.lng , this.rate , this.closeTime, this.openTime);
}

class _SingleCategoryPageState extends State<SingleCategoryPage> {
  int id;
  String cityAddressEn;
  String couponsTypeAr;
  String img;
  String lat;
  String lng;
  String rate ="";
  String closeTime ;
  String openTime ;

  _SingleCategoryPageState( this.id,this.cityAddressEn, this.couponsTypeAr, this.img,
      this.lat, this.lng , this.rate , this.closeTime, this.openTime);
  var messagesFirebaseRef, messagesFirebasemMetaRef;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messagesFirebaseRef = FirebaseDatabase().reference().child("favourite");
  }

  @override
  Widget build(BuildContext context) {
    double rating=double.parse(rate);
    Color color=Colors.blue;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(240, 240, 240, 1),
        drawer: NavigationDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              HeaderImage(),
              SizedBox(height: 20,),
              Container(
                height: MediaQuery.of(context).size.height,
                decoration: new BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: new BorderRadius.only(
                    topLeft: const Radius.circular(25.0),
                    topRight: const Radius.circular(25.0),
                  ),
                ),
                child: ListView(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 190,
                        child: Image.network(
                          "$img",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '$cityAddressEn',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    'Open ',
                                    style: TextStyle(fontSize: 12, color: Colors.green),
                                  ),
                                  Text(
                                    '.',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Text(
                                    ' Closes $closeTime',
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey.shade500),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                '$cityAddressEn',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey.shade500),
                              ),
                              Text(
                                '$couponsTypeAr',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey.shade500),
                              ),
                            ],
                          ),
                          Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    '$rate',
                                    style: TextStyle(color: Colors.grey.shade500),
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  SmoothStarRating(
                                    allowHalfRating: false,
                                    onRatingChanged: (value) {
                                      rating = value;
                                    },
                                    starCount: 5,
                                    rating: rating,
                                    size: 20.0,
                                    color: Colors.amber,
                                    borderColor: Colors.amber,
                                    spacing: 0.0,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    '',
                                    style: TextStyle(color: Colors.grey.shade500),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 50, left: 50),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                  Icon(
                                  Icons.call,
                                  color: Colors.blue,
                                  size: 25.0,
                                ),
                                    Icon(
                                      Icons.location_on,
                                      color: Colors.blue,
                                      size: 25.0,
                                    ),
                                    InkWell(
                                      onTap: (){
                                        ShopModel shop=ShopModel(id: widget.id, cityAr:widget.cityAddressEn ,cityEn:widget.cityAddressEn ,
                                            TradeAr:widget.couponsTypeAr , TradeEn: widget.couponsTypeAr ,type:  "0" , img: widget.img
                                        ,lng: widget.lng, lat: widget.lng, rate: widget.rate, closeTime: widget.closeTime, openTime: widget.openTime);

                                        messagesFirebaseRef.child("${LocalSettings.userId}").push().set(shop.toJson());

                                        setState(() {
                                          color=Colors.red;
                                        });
                                      },
                                      child: Icon(
                                        Icons.star,
                                        color:color,
                                        size: 25.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                        height: 500,
                        child: MapPage(
                          lat,
                          lng,
                        )),
                    SizedBox(height: 10,),

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
