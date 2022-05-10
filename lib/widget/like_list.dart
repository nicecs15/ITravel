import 'package:flutter/material.dart';
import 'package:myapp1/utility/my_style.dart';

class LikeList extends StatefulWidget {
  const LikeList({Key? key}) : super(key: key);

  @override
  State<LikeList> createState() => _LikeListState();
}

class _LikeListState extends State<LikeList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: Text('สถานที่ท่องเที่ยวที่ชื่นชอบ'),
      ),
      body: Text('like'),
    );
  }
}
