import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/FAV/FavReview.dart';
import 'package:myapp1/FAV/FavReviewUI.dart';
import 'package:myapp1/model/addreview_north.dart';

import 'package:myapp1/utility/my_style.dart';

import 'package:myapp1/widget/reviewUI.dart';

class FavDetail extends StatefulWidget {
  final DocumentSnapshot fav;

  FavDetail({required this.fav});

  @override
  State<FavDetail> createState() => _FavDetailState();
}

class _FavDetailState extends State<FavDetail> {
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
      "name": widget.fav["name"],
      "img": widget.fav["img"],
      "province": widget.fav["province"],
      "detail": widget.fav["detail"],
    }).then((value) => print("add to favortie"));
  }

  bool isMore = false;
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
                widget.fav['img'],
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
                        widget.fav.get("name"),
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
                            .where("name", isEqualTo: widget.fav['name'])
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
                      widget.fav.get("province"),
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
                  widget.fav.get("detail"),
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                Divider(
                  thickness: 1.0,
                  color: Colors.black.withOpacity(0.8),
                  height: 32.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(("รีวิว"), style: TextStyle(fontSize: 18)),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FavReview(fav: widget.fav),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(),
                        child: Text("View All",
                            style: TextStyle(fontSize: 18, color: Colors.red)),
                      ),
                    ),
                  ],
                ),
                SingleChildScrollView(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(bottom: 8, top: 8),
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return FavReviewUI(
                        image: 'images/logo.png',
                        emailcomment: "Username",
                        datecomment: DateTime.now(),
                        comment: "Comment",
                        rating: 0,
                        onTap: () => setState(() {
                          isMore = !isMore;
                        }),
                        isLess: isMore,
                        fav: widget.fav,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        thickness: 1.0,
                        color: Colors.grey,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                openRatingDialog(context, widget.fav);
              },
              icon: Icon(
                Icons.star,
                size: 20,
                color: Colors.white,
              ),
              label: Text('เขียนรีวิว'),
            ),
          )
        ]),
      ),
    );
  }
}

openRatingDialog(context, fav) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ReviewNorth(
            north: fav,
          ));
}
