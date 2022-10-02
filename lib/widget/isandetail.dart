import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/model/addreview_isan.dart';
import 'package:myapp1/utility/my_style.dart';
import 'package:myapp1/widget/IsanReview.dart';
import 'package:myapp1/widget/IsanReviewUI.dart';

class IsanDetail extends StatefulWidget {
  final DocumentSnapshot isan;

  IsanDetail({required this.isan});
  @override
  State<IsanDetail> createState() => _IsanDetailState();
}

class _IsanDetailState extends State<IsanDetail> {
  Future getisan() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("isan").get();
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
      "name": widget.isan["name"],
      "img": widget.isan["img"],
      "province": widget.isan["province"],
      "detail": widget.isan["detail"],
    }).then((value) => print("add to favortie"));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isMore = false;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: Text('สถานที่ท่องเที่ยวภาคอีสาน'),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            children: [
              Image.network(
                widget.isan.get('img'),
                height: 300.0,
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
                        widget.isan.get("name"),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("users_favorite_items")
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .collection("items")
                            .where("name", isEqualTo: widget.isan['name'])
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
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(
                      Icons.location_pin,
                      size: 24,
                      color: Colors.red,
                    ),
                    Expanded(
                        child: Text(
                      widget.isan.get("province"),
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    )),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  widget.isan.get("detail"),
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      openRatingDialog(context, widget.isan);
                    },
                    icon: Icon(
                      Icons.star,
                      size: 20,
                      color: Colors.white,
                    ),
                    label: Text('Review'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(("รีวิว"), style: TextStyle(fontSize: 18)),
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => IsanReview(isan: widget.isan),
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
                      return IsanReviewUI(
                        image: 'images/logo.png',
                        emailcomment: "Username",
                        datecomment: DateTime.now(),
                        comment: "Comment",
                        rating: 0,
                        onTap: () => setState(() {
                          isMore = !isMore;
                        }),
                        isLess: isMore,
                        isan: widget.isan,
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
        ]),
      ),
    );
  }
}

openRatingDialog(context, isan) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ReviewIsan(
            isan: isan,
          ));
}
