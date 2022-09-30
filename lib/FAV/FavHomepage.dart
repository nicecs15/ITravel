import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/FAV/FavIsanList.dart';
import 'package:myapp1/utility/my_style.dart';
import 'package:myapp1/widget/central_list.dart';
import 'package:myapp1/widget/isan_list.dart';
import 'package:myapp1/widget/north_list.dart';
import 'package:myapp1/widget/searchall.dart';
import 'package:myapp1/widget/south_list.dart';

import 'FavCentralList.dart';
import 'FavNorthList.dart';
import 'FavSouthList.dart';

class FavHomepage extends StatefulWidget {
  FavHomepage({Key? key}) : super(key: key);

  @override
  State<FavHomepage> createState() => _FavHomepageState();
}

class _FavHomepageState extends State<FavHomepage> {
  late double screen;
  Widget currentWidget = FavHomepage();

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SafeArea(
            child: Container(
                margin: EdgeInsets.only(top: 30),
                child: Column(children: [
                  Expanded(
                      child: Container(
                    padding: const EdgeInsets.all(9.0), //ขยับขอบ
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        buildNorthMenu(),
                        buildIsanMenu(),
                        buildCentralMenu(),
                        buildSouthMenu(),
                      ],
                    ),
                  ))
                ]))));
  }

  ////////////////////////////////////////////////////////////////////////
  GestureDetector buildNorthMenu() {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => FavNorthList())),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        elevation: 4,
        child: (Image.asset('images/north.png')),
      ),
    );
  }

  GestureDetector buildIsanMenu() {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => FavIsanList())),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        elevation: 4,
        child: (Image.asset('images/isan.png')),
      ),
    );
  }

  GestureDetector buildCentralMenu() {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => FavCentralList())),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        elevation: 4,
        child: (Image.asset('images/central.png')),
      ),
    );
  }

  GestureDetector buildSouthMenu() {
    return GestureDetector(
      onTap: () => Navigator.push(
          context, MaterialPageRoute(builder: (context) => FavSouthList())),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        elevation: 4,
        child: (Image.asset('images/south.png')),
      ),
    );
  }
}
