import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/utility/my_style.dart';
import 'package:myapp1/widget/SouthReviewUI.dart';

class SouthReview extends StatefulWidget {
  final DocumentSnapshot south;
  SouthReview({Key? key, required this.south}) : super(key: key);

  @override
  State<SouthReview> createState() => _SouthReviewState();
}

class _SouthReviewState extends State<SouthReview> {
  bool isMore = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              return SouthReviewUI(
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
                south: widget.south,
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
