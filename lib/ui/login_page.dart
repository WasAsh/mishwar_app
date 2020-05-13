import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    final data = MediaQuery.of(context) ;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: data.size.height,
              width: data.size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: ExactAssetImage(
                    'assets/img/12.jpg' ,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 50),
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'مشوار' ,
                  style: TextStyle(
                    fontSize: 70 ,
                    fontWeight: FontWeight.w900 ,
                    color: Colors.red ,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 300),
              child: Align(
                alignment: Alignment.center ,
                child: Column(
                  children: <Widget>[
                    _homeButtons(Icon(Icons.email , color: Colors.grey,) , 'Sign Up with Email') ,
                    _homeButtons(Icon(Zocial.facebook , color: Colors.blueAccent.shade700,) , 'Sign Up with FaceBook') ,
                    _homeButtons(Icon(MaterialCommunityIcons.twitter , color: Colors.lightBlueAccent.shade200,) , 'Sign Up with Twitter') ,
                    _homeButtons(Icon(AntDesign.google , color: Colors.black,) , 'Sign Up with Google') ,
                    _homeButtons(Icon(Icons.person , color: Colors.redAccent,) , 'Already have an account? Log In') ,
                    FlatButton(
                      onPressed: (){},
                      child: Text(
                        'Not Now' ,
                        style: TextStyle(
                          fontWeight: FontWeight.w800 ,
                          color: Colors.white ,
                          decoration: TextDecoration.underline ,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _homeButtons (Icon icon , String title){
    return Container(
      child: RaisedButton(
        onPressed: (){},
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20) ,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            icon ,
            SizedBox(
              width: 10,
            ),
            Text(
                title ,
            ),
          ],
        ),
      ),
      width: 320,
    );
  }


}

