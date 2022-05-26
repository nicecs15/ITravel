import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/model/addlist_central.dart';
import 'package:myapp1/utility/my_style.dart';
import 'package:myapp1/widget/centraldetail.dart';

class CentralList extends StatefulWidget {
  const CentralList({Key? key}) : super(key: key);

  @override
  State<CentralList> createState() => _CentralListState();
}

class _CentralListState extends State<CentralList> {
  navigateToDetail(DocumentSnapshot central) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CentralDetail(central: central)));
  }

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
                              Image.network(document["img"], fit: BoxFit.cover),
                        ),
                        title: Text(document["name"]),
                        subtitle: Text(document["province"]),
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return CentralDetail(
                              central: document,
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
              context, MaterialPageRoute(builder: (_) => AddListCentral()));
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
