import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReviewCentral extends StatefulWidget {
  final DocumentSnapshot central;
  final String? comment;
  final DateTime? datecomment;
  ReviewCentral({required this.central, this.comment, this.datecomment});

  @override
  State<ReviewCentral> createState() => _ReviewCentralState();
}

class _ReviewCentralState extends State<ReviewCentral> {
  final Future<FirebaseApp> firebase = Firebase.initializeApp();
  var datecomment = DateTime;
  String? comment;
  String? emailcomment;
  double? rating;
  final formKey = GlobalKey<FormState>();

  Future<void> addToReview(name) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    var currentUser = _auth.currentUser;

    Map<String, dynamic> map = Map();
    map['comment'] = comment;
    map['datecomment'] = DateTime.now();
    map['rating'] = rating;
    map['emailcomment'] = currentUser!.displayName;

    await firebaseFirestore
        .collection('central')
        .doc(name)
        .collection("reviewcentral")
        .doc()
        .set(map)
        .then((value) {
      print('addreview');
    });
  }

  @override
  Widget build(BuildContext context) {
    return RatingDialog(
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
        onCancelled: () => print('cancelled'),
        onSubmitted: (response) {
          comment = response.comment;
          rating = response.rating;
          addToReview(widget.central['name']);
        });
  }
}