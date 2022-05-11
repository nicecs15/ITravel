import 'package:flutter/material.dart';
import 'package:myapp1/utility/my_style.dart';

class IsanList extends StatefulWidget {
  const IsanList({Key? key}) : super(key: key);

  @override
  State<IsanList> createState() => _IsanListState();
}

class _IsanListState extends State<IsanList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: Text('สถานที่ท่องเที่ยวในภาคอีสาน'),
      ),
      body: Text('จี่หอย'),
    );
  }
}
