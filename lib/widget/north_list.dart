import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/model/upload_status.dart';
import 'package:myapp1/utility/my_style.dart';
import 'package:myapp1/widget/detail.dart';

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

      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("north").snapshots(),
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
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return NorthDetail();
                          }));
                        }));
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
