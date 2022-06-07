import 'package:flutter/material.dart';
import 'package:myapp1/utility/my_style.dart';
import 'package:myapp1/widget/reviewUI.dart';

class NorthReview extends StatefulWidget {
  NorthReview({Key? key}) : super(key: key);

  @override
  State<NorthReview> createState() => _NorthReviewState();
}

class _NorthReviewState extends State<NorthReview> {
  bool isMore = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: const Text('รีวิว'),
      ),
      body: ListView.separated(
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (contex, index) {
          return ReviewUI(
            image: 'images/logo.png',
            name: "Username",
            date: "07 Jun 2022",
            comment:
                "CommentCommentCommentCommentCommentCommentCommentCommentCommentCommentCommentCommentComment",
            rating: 4.5,
            onTap: () => setState(() {
              isMore = !isMore;
            }),
            isLess: isMore,
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 1,
            color: Colors.grey,
          );
        },
      ),
    );
  }
}
