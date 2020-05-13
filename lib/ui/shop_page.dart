import 'package:flutter/material.dart';
import 'package:mishwar_app/shared/nav_drawer.dart';

class ShopPage extends StatefulWidget {
  ShopPage({Key key}) : super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: NavigationDrawer(),
        body: Center(
          child: Container(
            child: Text("Coming Soon"),
          ),
        ),
      ),
    );
  }
}
