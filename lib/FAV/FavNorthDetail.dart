import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/model/addreview_north.dart';
import 'package:myapp1/utility/my_style.dart';
import 'package:myapp1/widget/authen.dart';
import 'package:myapp1/widget/northreview.dart';
import 'package:myapp1/widget/reviewUI.dart';
import 'package:myapp1/model/addreview_north.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FavNorthDetail extends StatefulWidget {
  final DocumentSnapshot north;

  FavNorthDetail({required this.north});

  @override
  State<FavNorthDetail> createState() => _FavNorthDetailState();
}

class _FavNorthDetailState extends State<FavNorthDetail> {
  Future getnorth() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("north").get();
    return qn.docs;
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
                widget.north.get('img'),
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
                        widget.north.get("name"),
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
                      widget.north.get("province"),
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
                  widget.north.get("detail"),
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
                      _onAlertButtonsPressed(context);
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
                          builder: (context) =>
                              NorthReview(north: widget.north),
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
                      return ReviewUI(
                        image: 'images/logo.png',
                        emailcomment: "Username",
                        datecomment: DateTime.now(),
                        comment: "Comment",
                        rating: 0,
                        onTap: () => setState(() {
                          isMore = !isMore;
                        }),
                        isLess: isMore,
                        north: widget.north,
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

openRatingDialog(context, north) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ReviewNorth(
            north: north,
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
