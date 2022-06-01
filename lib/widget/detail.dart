import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/utility/my_style.dart';

class NorthDetail extends StatefulWidget {
  final DocumentSnapshot north;

  NorthDetail({required this.north});

  @override
  State<NorthDetail> createState() => _NorthDetailState();
}

class _NorthDetailState extends State<NorthDetail> {
  Future getnorth() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("north").get();
    return qn.docs;
  }

  Future addToFavorite() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUser = _auth.currentUser;
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection("users_favorite_items");
    return _collectionRef
        .doc(currentUser!.email)
        .collection("items")
        .doc()
        .set({
      "name": widget.north["name"],
      "img": widget.north["img"],
      "province": widget.north["province"],
      "detail": widget.north["detail"],
    }).then((value) => print("add to favortie"));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: const Text('สถานที่ท่องเที่ยวภาคเหนือ'),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            children: [
              Image.network(
                widget.north.get('img'),
                height: 400.0,
                width: size.width,
                fit: BoxFit.cover,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      width: size.width / 2,
                      child: Text(
                        widget.north.get("name"),
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("users_favorite_items")
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .collection("items")
                            .where("name", isEqualTo: widget.north['name'])
                            .snapshots(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.data == null) {
                            return Text("");
                          }
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              child: IconButton(
                                  onPressed: () =>
                                      snapshot.data.docs.length == 0
                                          ? addToFavorite()
                                          : print("Alread added"),
                                  icon: snapshot.data.docs.length == 0
                                      ? Icon(
                                          Icons.favorite_outline,
                                          size: 18,
                                          color: Colors.white,
                                        )
                                      : Icon(
                                          Icons.favorite,
                                          color: Colors.white,
                                        )),
                            ),
                          );
                        }),
                  ],
                ),
                Divider(
                  thickness: 1.0,
                  color: Colors.black.withOpacity(0.8),
                  height: 32.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.share,
                      size: 24,
                      color: Colors.green,
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                        child: Text(
                      widget.north.get("province"),
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    )),
                  ],
                ),
                Divider(
                  thickness: 1.0,
                  color: Colors.black.withOpacity(0.8),
                  height: 32.0,
                ),
                Text(
                  widget.north.get("detail"),
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                Container(
                  height: 64.0,
                  width: size.width,
                  margin: const EdgeInsets.only(top: 16.0),
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 208, 212, 214),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 32.0,
                        width: 32.0,
                        padding: const EdgeInsets.all(8.0),
                        margin: const EdgeInsets.only(right: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        child: Image.asset("images/write.png"),
                      ),
                      const Expanded(
                        child: const TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Write a comment ..555..",
                            hintStyle: const TextStyle(
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 32.0,
                        width: 32.0,
                        padding: EdgeInsets.all(9.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(32.0),
                        ),
                        child: Image.asset("images/sendcom.png"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
