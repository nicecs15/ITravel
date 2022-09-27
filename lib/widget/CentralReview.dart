import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/utility/my_style.dart';

import 'CentralReviewUI.dart';

class CentralReview extends StatefulWidget {
  final DocumentSnapshot central;
  CentralReview({Key? key, required this.central}) : super(key: key);

  @override
  State<CentralReview> createState() => _CentralReviewState();
}

class _CentralReviewState extends State<CentralReview> {
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
              return CentralReviewUI(
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
                central: widget.central,
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
