import 'package:flutter/material.dart';
import 'package:myapp1/utility/my_style.dart';

class CentralList extends StatefulWidget {
  const CentralList({Key? key}) : super(key: key);

  @override
  State<CentralList> createState() => _CentralListState();
}

class _CentralListState extends State<CentralList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: Text('สถานที่ท่องเที่ยวในภาคกลาง'),
      ),
      body: Text('this is Central'),
    );
  }
}
