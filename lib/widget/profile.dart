import 'package:flutter/material.dart';
import 'package:myapp1/utility/my_style.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: Text('โปรไฟล์'),
      ),
      body: Text('หน้าโปรไฟล์ไอสัสอย่าเรื่องเยอะ'),
    );
  }
}
