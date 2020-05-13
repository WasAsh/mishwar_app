import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mishwar_app/shared/single_category_page.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'header_image.dart';
import 'map_widget.dart';

class ShopItem extends StatelessWidget {
  int id;
  String cityAddressEn;
  String couponsTypeAr;
  String img;
  String lat;
  String lng;
  String rate ;
  String closeTime ;
  String openTime ;

  ShopItem( this.id, this.cityAddressEn, this.couponsTypeAr, this.img,
      this.lat, this.lng , this.rate , this.closeTime, this.openTime);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
//        _singleCategoryPage(context);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SingleCategoryPage(this.id, this.cityAddressEn, this.couponsTypeAr, this.img,
                this.lat, this.lng , this.rate , this.closeTime, this.openTime)));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Container(
                  width: 100,
                  height: 60,
                  child: Image.network(
                    "$img",
                    fit: BoxFit.cover,
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
                      '$cityAddressEn',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '$cityAddressEn',
                      style: TextStyle(color: Colors.grey, fontSize: 8),
                    ),
                    SizedBox(
                      height: 2.5,
                    ),
                    Text(
                      '$cityAddressEn',
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
      ),
    );
  }

  void _singleCategoryPage(BuildContext context) {
    double rating = 5;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Column(
        children: <Widget>[
          HeaderImage(),
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
                HeaderImage(),
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
                              children: <Widget>[],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                    height: 500,
                    width: 100,
                    child: MapPage(
                      lat,
                      lng,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
