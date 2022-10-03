import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/model/addlist_isan.dart';
import 'package:myapp1/utility/my_style.dart';
import 'package:myapp1/widget/isandetail.dart';

class IsanList extends StatefulWidget {
  const IsanList({Key? key}) : super(key: key);

  @override
  State<IsanList> createState() => _IsanListState();
}

class _IsanListState extends State<IsanList> {
  var inputText = "";
  navigateToDetail(DocumentSnapshot isan) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => IsanDetail(isan: isan)));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: const Text('สถานที่ท่องเที่ยวในภาคอีสาน'),
      ),
      body: Column(children: [
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
                  .where("sector", isEqualTo: "อีสาน")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
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
                              child: Image.network(document["img"],
                                  fit: BoxFit.cover),
                            ),
                            title: Text(document["name"]),
                            subtitle: Text(document["province"]),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return IsanDetail(
                                  isan: document,
                                );
                              }));
                            }));
                  }).toList(),
                );
              }),
        ),
      ]),

      //////////// addproto
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddListIsan()));
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
