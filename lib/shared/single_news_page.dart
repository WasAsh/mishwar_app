import 'package:flutter/material.dart';

class SingleNewsPage extends StatefulWidget {
  String title;
  String details;
  String postDate;
  String img;

  SingleNewsPage(this.title, this.details, this.postDate, this.img);

  @override
  _SingleNewsPageState createState() => _SingleNewsPageState();
}

class _SingleNewsPageState extends State<SingleNewsPage> {
  @override
  Widget build(BuildContext context) {
    final res2 = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(240, 240, 240, 1),
        body: Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 20, left: 20),
              child: ListView(
                children: <Widget>[
                  Container(
                    width: res2.size.width * 0.5,
                    height: 190,
                    child: Image.network(
                      "${widget.img}",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Text(
                      '${widget.postDate}',
                      style: TextStyle(color: Colors.grey, fontSize: 8),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Text(
                      '${widget.title}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    child: Text(
                      '${widget.details}',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        height: 1.25,
                      ),
                    ),
                  ),
                ],
              ),
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
}
