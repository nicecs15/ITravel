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
        margin: EdgeInsets.only(top: 55),
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
      ),
    );
  }

  ////////////////////////////////////////////////////////////////////////
  GestureDetector buildNorthMenu() {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/north_list'),
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
      onTap: () => Navigator.pushNamed(context, '/isan_list'),
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
      onTap: () => Navigator.pushNamed(context, '/central_list'),
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
      onTap: () => Navigator.pushNamed(context, '/south_list'),
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
