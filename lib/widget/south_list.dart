import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/utility/my_style.dart';

import '../model/upload_status.dart';

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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("south").snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data!.docs.map((document) {
                return Card(
                    child: ListTile(
                  leading: Image.network(document["img"]),
                  title: Text(document["name"]),
                  subtitle: Text(document["detail"]),
                ));
              }).toList(),
            );
          }),

      //////////// addproto
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => UploadStaus()));
        },
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}
