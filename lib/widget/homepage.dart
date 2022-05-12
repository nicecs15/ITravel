import 'package:flutter/material.dart';
import 'package:myapp1/utility/my_style.dart';
import 'package:myapp1/widget/central_list.dart';
import 'package:myapp1/widget/isan_list.dart';
import 'package:myapp1/widget/north_list.dart';
import 'package:myapp1/widget/searchbar.dart';
import 'package:myapp1/widget/south_list.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  late double screen;
  Widget currentWidget = Homepage();

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 60),
        padding: const EdgeInsets.all(9.0), //ขยับขอบ
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: .85,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            buildListTileNorthList(),
            buildListTileIsanList(),
            buildListTileCentralList(),
            buildListTileSouthList(),
          ],
        ),
      ),
    );
  }

  ////////////////////////////////////////////////////////////////////////
  Card buildListTileNorthList() {
    return Card(
      child: (Image.asset('images/north1.png')),
    );
  }

  Card buildListTileIsanList() {
    return Card(
      child: (Image.asset('images/isan1.png')),
    );
  }

  Card buildListTileCentralList() {
    return Card(
      child: (Image.asset('images/central1.png')),
    );
  }

  Card buildListTileSouthList() {
    return Card(
      child: (Image.asset('images/south1.png')),
    );
  }
}
