import 'package:flutter/material.dart';
import 'package:myapp1/utility/my_style.dart';
import 'package:myapp1/widget/central_list.dart';
import 'package:myapp1/widget/isan_list.dart';
import 'package:myapp1/widget/north_list.dart';
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
      body: Column(
        children: [
          buildListTileNorthList(),
          buildListTileIsanList(),
          buildListTileCentralList(),
          buildListTileSouthList(),
        ],
      ),
    );
  }

  ListTile buildListTileNorthList() {
    return ListTile(
      leading: Image.asset('images/north.png', width: screen * .10),
      title: MyStyle().titleH3('ภาคเหนือ'),
      subtitle: Text('รวมสถานที่ท่องเที่ยวในภาคเหนือ'),
      onTap: () => Navigator.pushNamed(context, '/north_list'),
    );
  }

  ListTile buildListTileIsanList() {
    return ListTile(
      leading: Image.asset('images/isan.png', width: screen * .10),
      title: MyStyle().titleH3('ภาคอีสาน'),
      subtitle: Text('รวมสถานที่ท่องเที่ยวในภาคอีสาน'),
      onTap: () => Navigator.pushNamed(context, '/isan_list'),
    );
  }

  ListTile buildListTileCentralList() {
    return ListTile(
      leading: Image.asset('images/central.png', width: screen * .10),
      title: MyStyle().titleH3('ภาคกลาง'),
      subtitle: Text('รวมสถานที่ท่องเที่ยวในภาคกลาง'),
      onTap: () => Navigator.pushNamed(context, '/central_list'),
    );
  }

  ListTile buildListTileSouthList() {
    return ListTile(
      leading: Image.asset('images/south.png', width: screen * .10),
      title: MyStyle().titleH3('ภาคใต้'),
      subtitle: Text('รวมสถานที่ท่องเที่ยวในภาคใต้'),
      onTap: () => Navigator.pushNamed(context, '/south_list'),
    );
  }
}
