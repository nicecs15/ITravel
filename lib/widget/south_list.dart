import 'package:flutter/material.dart';
import 'package:myapp1/utility/my_style.dart';

class SouthList extends StatefulWidget {
  const SouthList({Key? key}) : super(key: key);

  @override
  State<SouthList> createState() => _SouthListState();
}

class _SouthListState extends State<SouthList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: Text('สถานที่ท่องเที่ยวในภาคใต้'),
      ),
      body: Text('this is south'),
    );
  }
}
