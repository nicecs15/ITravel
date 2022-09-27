import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/utility/my_style.dart';
import 'package:myapp1/widget/IsanReviewUI.dart';

class IsanReview extends StatefulWidget {
  final DocumentSnapshot isan;
  IsanReview({Key? key, required this.isan}) : super(key: key);

  @override
  State<IsanReview> createState() => _IsanReviewState();
}

class _IsanReviewState extends State<IsanReview> {
  bool isMore = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: const Text('รีวิว'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: ListView.separated(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.only(bottom: 8, top: 8),
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (contex, index) {
              return IsanReviewUI(
                image: 'images/logo.png',
                emailcomment: "Username",
                datecomment: DateTime(1),
                comment:
                    "CommentCommentCommentCommentCommentCommentCommentCommentCommentCommentCommentCommentComment",
                rating: 4.5,
                onTap: () => setState(() {
                  isMore = !isMore;
                }),
                isLess: isMore,
                isan: widget.isan,
              );
            },
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 1,
                color: Colors.grey,
              );
            },
          ),
        ),
      ),
    );
  }
}
