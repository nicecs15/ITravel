import 'package:flutter/material.dart';
import 'package:myapp1/model/upload_status.dart';
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
        title: const Text('สถานที่ท่องเที่ยวในภาคเหนือ'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => UploadStaus()));
        },
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
