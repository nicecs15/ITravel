import 'package:flutter/material.dart';
import 'package:myapp1/utility/my_style.dart';

class NorthDetail extends StatelessWidget {
  const NorthDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: Text('ที่เที่ยว'),
      ),
    );
  }
}
