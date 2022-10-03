import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/model/addlist_north.dart';
import 'package:myapp1/utility/my_style.dart';
import 'package:myapp1/widget/detail.dart';

class NorthList extends StatefulWidget {
  const NorthList({Key? key}) : super(key: key);

  @override
  State<NorthList> createState() => _NorthListState();
}

class _NorthListState extends State<NorthList> {
  var inputText = "";
  navigateToDetail(DocumentSnapshot north) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => NorthDetail(north: north)));
  }

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
                  decoration: InputDecoration(
                      hintText: "ค้นหาสถานที่ท่องเที่ยว",
                      hintStyle: TextStyle(
                        color: Colors.black.withAlpha(120),
                      ),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(color: Colors.black)),
                      prefixIcon: Icon(Icons.search),
                      prefixIconColor: Colors.purple.shade800),
                  onChanged: ((val) {
                    setState(() {
                      inputText = val;
                      print(inputText);
                    });
                  })),
            ),
          ),
          Expanded(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("Travel")
                    .where("sector", isEqualTo: "เหนือ")
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: Text("Loading"),
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
                              subtitle: Text(document["province"]),
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return NorthDetail(
                                    north: document,
                                  );
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
              context, MaterialPageRoute(builder: (_) => AddListNorth()));
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
