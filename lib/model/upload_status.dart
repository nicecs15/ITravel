import 'package:flutter/material.dart';
import 'package:myapp1/utility/my_style.dart';

class UploadStaus extends StatefulWidget {
  @override
  _UploadStausState createState() => _UploadStausState();
}

class _UploadStausState extends State<UploadStaus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: const Text("เพิ่มสถานที่ท่องเที่ยว"),
      ),
    );
  }
}
