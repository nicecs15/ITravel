import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/model/addreview_south.dart';
import 'package:myapp1/model/south_model.dart';
import 'package:myapp1/utility/my_style.dart';
import 'package:myapp1/widget/SouthReview.dart';
import 'package:myapp1/widget/SouthReviewUI.dart';
import 'package:myapp1/widget/authen.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FavSouthDetail extends StatefulWidget {
  final DocumentSnapshot south;

  FavSouthDetail({required this.south});

  @override
  State<FavSouthDetail> createState() => _FavSouthDetailState();
}

class _FavSouthDetailState extends State<FavSouthDetail> {
  bool isMore = false;

  Future getsouth() async {
    var firestore = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestore.collection("south").get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: Text('สถานที่ท่องเที่ยวภาคใต้'),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Stack(
            children: [
              Image.network(
                widget.south.get('img'),
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
                        widget.south.get("name"),
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
                      widget.south.get("province"),
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
                  widget.south.get("detail"),
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
                              SouthReview(south: widget.south),
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
                      return SouthReviewUI(
                        image: 'images/logo.png',
                        emailcomment: "Username",
                        datecomment: DateTime.now(),
                        comment: "Comment",
                        rating: 0,
                        onTap: () => setState(() {
                          isMore = !isMore;
                        }),
                        isLess: isMore,
                        south: widget.south,
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

openRatingDialog(context, south) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => ReviewSouth(
            south: south,
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
