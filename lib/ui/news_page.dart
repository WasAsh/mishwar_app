import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mishwar_app/models/news.dart';
import 'package:mishwar_app/shared/header_image.dart';
import 'package:mishwar_app/shared/nav_drawer.dart';
import 'package:mishwar_app/shared/single_news_page.dart';
import 'package:mishwar_app/utils/LocalSettings.dart';

class NewsPage extends StatefulWidget {
  NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  var messagesFirebaseRef, messagesFirebasemMetaRef;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    messagesFirebaseRef = FirebaseDatabase().reference().child("news");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(240, 240, 240, 1),
        drawer: NavigationDrawer(),
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
          List<NewsModel> msgs = List<NewsModel>();

          data.forEach((key, values) {
            var chatMsg = NewsModel(
              detailsAr:  LocalSettings.appLocale == "en" ?values["detailsEn"]:values["detailsAr"],
              titleAr:  LocalSettings.appLocale == "en" ?values["titleEn"]:values["titleAr"],
              postDate:values['postDate'],
              img: values["img"],
            );
            msgs.add(chatMsg);
          });

          return SliverList(
              delegate: SliverChildBuilderDelegate((context, position) {
                return _newsItemRow(
                    msgs[position].titleAr,
                    msgs[position].detailsAr,
                    msgs[position].postDate,
                    msgs[position].img,
                  context
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
}}

Widget _newsItemRow(String title,
    String details,
    String postDate,
    String img,
    BuildContext context) {
  String firstHalf , secondHalf;
  if (details.length > 50) {
    firstHalf = details.substring(0, 50);
    secondHalf = details.substring(50, details.length);
  } else {
    firstHalf = details;
    secondHalf = "";
  }
  return Padding(
    padding: const EdgeInsets.only(right: 20, left: 20),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      '$title',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),

                    secondHalf.isEmpty
                        ?   Text(
                      '$firstHalf',
                      maxLines: 4,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,

                        height: 1.25,
                      ),
                    )
                        : new Column(
                      children: <Widget>[
                        Text(
                         (firstHalf + "...") ,
                          maxLines: 4,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                            height: 1.25,
                          ),
                        ),

                        new InkWell(
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              new Text(
                               "show more" ,
                                style: new TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.push(context, PageRouteBuilder(
                              pageBuilder: (BuildContext context, Animation<double> animation,
                                  Animation<double> secondaryAnimation) {
                                return SingleNewsPage(title,details,postDate,img);
                              },
                              transitionsBuilder: (BuildContext context,
                                  Animation<double> animation,
                                  Animation<double> secondaryAnimation, Widget child) {
                                return SlideTransition(
                                  position: new Tween<Offset>(
                                    begin: const Offset(-1.0, 0.0),
                                    end: Offset.zero,
                                  ).animate(animation),
                                  child: new SlideTransition(
                                    position: new Tween<Offset>(
                                      begin: Offset.zero,
                                      end: const Offset(-1.0, 0.0),
                                    ).animate(secondaryAnimation),
                                    child: child,
                                  ),
                                );
                              },
                            ),
                            );
                          },
                        ),
                      ],
                    ),



                    SizedBox(height: 5),
                    Text(
                      '$postDate',
                      style: TextStyle(color: Colors.grey, fontSize: 8),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 100,
              ),
              Expanded(
                child: Container(
                  width: 105,
                  height: 110,
                 child: Image.network("$img"),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
