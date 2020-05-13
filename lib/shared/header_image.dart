import 'package:flutter/material.dart';

class HeaderImage extends StatefulWidget {
  @override
  _HeaderImageState createState() => _HeaderImageState();
}

class _HeaderImageState extends State<HeaderImage> {
  @override
  Widget build(BuildContext context) {

    final res = MediaQuery.of(context);

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Container(
          width: res.size.width,
          height: 160,
          decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.fill,
                image: ExactAssetImage('assets/img/12.jpg')
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 50),
          child: Container(
            width: 100,
            height: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: ExactAssetImage('assets/img/logo.png')
              ),
            ),
          ),
        ),
      ],
    );
  }
}
