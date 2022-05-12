import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/utility/my_style.dart';

import '../model/upload_status.dart';

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
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("central").snapshots(),
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
