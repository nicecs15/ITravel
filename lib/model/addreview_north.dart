import 'package:flutter/material.dart';
import 'package:rating_dialog/rating_dialog.dart';

class ReviewNorth extends StatefulWidget {
  ReviewNorth({Key? key}) : super(key: key);

  @override
  State<ReviewNorth> createState() => _ReviewNorthState();
}

class _ReviewNorthState extends State<ReviewNorth> {
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
      commentHint: 'comment',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');
        print('Day ${now.day} Month ${now.month} Year ${now.year}');
        // TODO: add your own logic
        if (response.rating < 3.0) {
          // send their comments to your email or anywhere you wish
          // ask the user to contact you instead of leaving a bad review
        } else {
          ReviewNorth();
        }
      },
    );
  }
}

var now = DateTime.now();
