import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReviewNorth extends StatefulWidget {
  final DocumentSnapshot north;
  ReviewNorth({required this.north});

  @override
  State<ReviewNorth> createState() => _ReviewNorthState();
}

class _ReviewNorthState extends State<ReviewNorth> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  var now = DateTime.now();

  Future<void> addToReview(name) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var currentUser = _auth.currentUser;
    String? comment;
    double? rating;
    Map<String, dynamic> map = Map();
    map['comment'] = comment;
    map['datecomment'] = DateTime.now();
    map['ratingcomment'] = rating;

    await firebaseFirestore
        .collection('north')
        .doc(name)
        .collection("reviewnorth")
        .doc(currentUser!.email)
        .set(map)
        .then((value) {
      print('addreview');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RatingDialog(
          title: Text(
            'เขียนรีวิวสถานที่',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          // encourage your user to leave a high rating?
          message: Text(
            'ให้คะแนนสถานที่ท่องเที่ยว',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15),
          ),
          // your app's logo?
          image: (Image.asset(
            'images/logo.png',
            width: 60,
            height: 90,
          )),
          submitButtonText: 'รีวิว',
          commentHint: 'comment',
          onCancelled: () => print('cancelled'),
          onSubmitted: (response) {
            print('rating: ${response.rating}, comment: ${response.comment}');
            print('Day ${now.day} Month ${now.month} Year ${now.year}');
            // TODO: add your own logic

            addToReview(widget.north['name']);
          }),
    );
  }
}
