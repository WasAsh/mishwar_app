import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mishwar_app/shared/header_image.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MishwarPage extends StatefulWidget {

  MishwarPage({Key key}) : super(key: key);

  @override
  _MishwarPageState createState() => _MishwarPageState();
}

class _MishwarPageState extends State<MishwarPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromRGBO(240, 240, 240, 1),
        body: ListView(
          children: <Widget>[
            HeaderImage(),
            SizedBox(height: 10,),
            _imageDrawer(160) ,
            SizedBox(height: 10,),
            _imageDrawer(160) ,
            SizedBox(height: 10,),
            _imageDrawer(160) ,
            SizedBox(height: 10,),
            _imageDrawer(160) ,
            SizedBox(height: 10,),
            _imageDrawer(160) ,
            SizedBox(height: 10,),
            _imageDrawer(160) ,
            SizedBox(height: 10,),
            _imageDrawer(300) ,
            SizedBox(height: 40,),
            HeaderImage(),
            SizedBox(height: 30,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'support@mishwar.app',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12 ,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  'mishwar.app',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12 ,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Entypo.facebook_with_circle , color: Colors.red.shade700, size: 30,),
                      onPressed: (){},
                    ),
                    IconButton(
                      icon: Icon(Entypo.instagram_with_circle , color: Colors.red.shade700, size: 30,),
                      onPressed: (){},
                    ),
                    IconButton(
                      icon: Icon(Entypo.twitter_with_circle , color: Colors.red.shade700, size: 30,),
                      onPressed: (){},
                    ),
                  ],
                ),
                SizedBox(height: 30,),
                Text(
                  '2019/08 . Edition 190 . Year 16',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12 ,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


Widget _imageDrawer(double _height) {
  return Padding(
    padding: const EdgeInsets.only(left: 10 , right: 10),
    child: Container(
      width: double.infinity ,
      height: _height,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
            image: ExactAssetImage('assets/img/12.jpg')
        ),
      ),
    ),
  );
}