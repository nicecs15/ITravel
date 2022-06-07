import 'package:flutter/material.dart';
import 'package:simple_star_rating/simple_star_rating.dart';

class ReviewUI extends StatelessWidget {
  final String? image, name, date, comment;
  final double? rating;
  final bool? isLess;
  const ReviewUI(
      {Key? key,
      this.image,
      this.name,
      this.date,
      this.comment,
      this.rating,
      this.isLess,
      required void Function() onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 2.0, right: 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 45.0,
                width: 45.0,
                margin: EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image!),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(44),
                ),
              ),
              Expanded(
                child: Text(
                  name!,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              SimpleStarRating(
                allowHalfRating: true,
                starCount: 5,
                rating: rating!,
                size: 28.0,
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                date!,
                style: TextStyle(fontSize: 18.0),
              ),
            ],
          ),
          SizedBox(height: 10),
          GestureDetector(
            child: isLess!
                ? Text(
                    comment!,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  )
                : Text(
                    comment!,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
          ),
        ],
      ),
    );
  }
}
