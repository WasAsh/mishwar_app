import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'map_widget.dart';

class CouponItem extends StatelessWidget {
  String cityAddressAr;
  String cityAddressEn;
  String couponsTypeAr;
  String img;

  CouponItem(
      this.cityAddressAr, this.cityAddressEn, this.couponsTypeAr, this.img);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        _singleCategoryPage(context);
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
                      '$cityAddressAr',
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
      ),
    );
  }

  void _singleCategoryPage(BuildContext context) {
    double rating = 5;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: new BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: new BorderRadius.only(
            topLeft: const Radius.circular(25.0),
            topRight: const Radius.circular(25.0),
          ),
        ),
        child:

        ListView(
          padding: EdgeInsets.only(left: 20, right: 20),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 190,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: ExactAssetImage('assets/img/12.jpg')),
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
                        'Chicken Spot',
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
                            ' Closes 11PM',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        '0123 Something Road',
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey.shade500),
                      ),
                      Text(
                        'Jerusalem, IL 20939',
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
                            '4.2',
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
                            '7,930',
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


          ],
        ),
      ),
    );
  }
}
