import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var inputText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: (val) {
                        setState(() {
                          inputText = val;
                          print(inputText);
                        });
                      },
                    ),
                    Expanded(
                        child: Container(
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection("")
                                    .where("name",
                                        isGreaterThanOrEqualTo: inputText)
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasError) {
                                    return Center(
                                      child: Text("ไม่พบสถานที่"),
                                    );
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                      child: Text("Loading"),
                                    );
                                  }
                                  return ListView(
                                    children: snapshot.data!.docs
                                        .map((DocumentSnapshot document) {
                                      Map<String, dynamic> data = document
                                          .data() as Map<String, dynamic>;
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
                                            child: Image.network(
                                                document["img"],
                                                fit: BoxFit.cover),
                                          ),
                                          title: Text(document["name"]),
                                          subtitle: Text(document["province"]),
                                        ),
                                      );
                                    }).toList(),
                                  );
                                }))),
                  ],
                ))));
  }
}
