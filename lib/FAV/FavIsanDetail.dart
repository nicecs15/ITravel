import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/model/addreview_isan.dart';
import 'package:myapp1/utility/my_style.dart';
import 'package:myapp1/widget/IsanReview.dart';
import 'package:myapp1/widget/IsanReviewUI.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../widget/authen.dart';

class FavIsanDetail extends StatefulWidget {
  final DocumentSnapshot isan;

  FavIsanDetail({required this.isan});
  @override
  State<FavIsanDetail> createState() => _FavIsanDetailState();
}

class _FavIsanDetailState extends State<FavIsanDetail> {
  Future getisan() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("isan").get();
    return qn.docs;
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
                        widget.isan.get("name"),
                        style: TextStyle(
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: CircleAvatar(
                        child: IconButton(
                          onPressed: () => _onAlertButtonsPressed(context),
                          icon: Icon(
                            Icons.favorite_outline,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                        backgroundColor: Colors.red,
                      ),
                    ),
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
                      widget.isan.get("province"),
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
                  widget.isan.get("detail"),
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
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                _onAlertButtonsPressed(context);
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

openRatingDialog(context, isan) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ReviewIsan(
            isan: isan,
          ));
}

_onAlertButtonsPressed(BuildContext context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "โปรดสมัครสมาชิกเพื่อเข้าสู่ระบบ",
    buttons: [
      DialogButton(
        child: Text(
          "ใช้งานต่อไป",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () => Navigator.pop(context),
        color: Color.fromRGBO(0, 179, 134, 1.0),
      ),
      DialogButton(
        child: Text(
          "เข้าสู่ระบบ",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => Authen())),
        gradient: LinearGradient(colors: [
          Color.fromRGBO(116, 116, 191, 1.0),
          Color.fromRGBO(52, 138, 199, 1.0),
        ]),
      )
    ],
  ).show();
}
