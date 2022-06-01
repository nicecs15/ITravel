import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/router.dart';
import 'package:myapp1/utility/my_style.dart';
import 'package:myapp1/widget/centraldetail.dart';
import 'package:myapp1/widget/detail.dart';
import 'package:myapp1/widget/isandetail.dart';
import 'package:myapp1/widget/southdetail.dart';

class LikeList extends StatefulWidget {
  @override
  State<LikeList> createState() => _LikeListState();
}

class _LikeListState extends State<LikeList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyStyle().primaryColor,
          title: Text('สถานที่ท่องเที่ยวที่ชื่นชอบ'),
        ),
        body: SafeArea(
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users_favorite_items")
                    .doc(FirebaseAuth
                        .instance.currentUser!.email) //ดึง doc ที่ใช้ gmail
                    .collection("items")
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Something is wrong"),
                    );
                  }

                  return ListView.builder(
                      itemCount: snapshot.data == null
                          ? 0
                          : snapshot.data!.docs.length,
                      itemBuilder: (_, index) {
                        DocumentSnapshot _documentSnapshot =
                            snapshot.data!.docs[index];

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
                                  child: Image.network(_documentSnapshot["img"],
                                      fit: BoxFit.cover),
                                ),
                                title: Text(_documentSnapshot["name"]),
                                subtitle: Text(_documentSnapshot["province"]),
                                trailing: GestureDetector(
                                    child: CircleAvatar(
                                      backgroundColor: Colors.red,
                                      child: Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                      ),
                                    ),
                                    onTap: () {
                                      FirebaseFirestore.instance
                                          .collection("users_favorite_items")
                                          .doc(FirebaseAuth
                                              .instance.currentUser!.email)
                                          .collection("items")
                                          .doc(_documentSnapshot.id)
                                          .delete();
                                    }),
                                onTap: () {}));
                      });
                })));
  }
}
