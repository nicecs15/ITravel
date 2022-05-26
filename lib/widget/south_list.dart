import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/model/addlist_south.dart';
import 'package:myapp1/utility/my_style.dart';
import 'package:myapp1/widget/southdetail.dart';

class SouthList extends StatefulWidget {
  const SouthList({Key? key}) : super(key: key);

  @override
  State<SouthList> createState() => _SouthListState();
}

class _SouthListState extends State<SouthList> {
  navigateToDetail(DocumentSnapshot south) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SouthDetail(south: south)));
  }

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
                    margin: EdgeInsets.all(6),
                    elevation: 3,
                    child: ListTile(
                        leading: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 102,
                            minHeight: 56,
                            maxWidth: 102,
                            maxHeight: 56,
                          ),
                          child:
                              Image.network(document['img'], fit: BoxFit.cover),
                        ),
                        title: Text(document['name']),
                        subtitle: Text(document['province']),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return SouthDetail(
                              south: document,
                            );
                          }));
                        }));
              }).toList(),
            );
          }),

      //////////// addproto
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddListSouth()));
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
