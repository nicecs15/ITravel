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
  TextEditingController addController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: const Text('สถานที่ท่องเที่ยวในภาคเหนือ'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: size.height / 30,
          ),
          Container(
              height: size.height / 14,
              width: size.width,
              alignment: Alignment.center,
              child: SizedBox(
                  height: size.height / 14,
                  width: size.width / 1.15,
                  child: TextField(
                      controller: addController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.search),
                          onPressed: () => {}.clear(),
                        ),
                        hintText: "ค้นหาสถานที่ท่องเที่ยว",
                      )))),
          Expanded(
            child: StreamBuilder(
                stream:
                    FirebaseFirestore.instance.collection("north").snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView(
                    children: snapshot.data!.docs.map((document) {
                      return Card(
                          margin: const EdgeInsets.all(6),
                          elevation: 3,
                          child: ListTile(
                              leading: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  minWidth: 102,
                                  minHeight: 56,
                                  maxWidth: 102,
                                  maxHeight: 56,
                                ),
                                child: Image.network(document["img"],
                                    fit: BoxFit.cover),
                              ),
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
          )
        ],
      ),

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
