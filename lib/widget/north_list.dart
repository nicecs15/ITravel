import 'package:flutter/material.dart';
import 'package:myapp1/utility/my_style.dart';

class NorthList extends StatefulWidget {
  const NorthList({Key? key}) : super(key: key);

  @override
  State<NorthList> createState() => _NorthListState();
}

class _NorthListState extends State<NorthList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: Text('สถานที่ท่องเที่ยวในภาคเหนือ'),
      ),
      body: Text('แก้ไข'),
    );
  }
}
