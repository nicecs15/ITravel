import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp1/model/firestorebuckets.dart';
import 'package:simple_star_rating/simple_star_rating.dart';

class IsanReviewUI extends StatelessWidget {
  final String? image, emailcomment, comment;
  final double? rating;
  final bool? isLess;
  final DateTime? datecomment;
  final DocumentSnapshot isan;
  IsanReviewUI({
    Key? key,
    required this.isan,
    this.image,
    this.emailcomment,
    this.comment,
    this.rating,
    this.isLess,
    this.datecomment,
    required void Function() onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    ScrollController controller = ScrollController();

    return Container(
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection(FirestoreBuckets.isan)
              .doc(isan['name'])
              .collection(FirestoreBuckets.reviewisan)
              .where("datecomment", isLessThanOrEqualTo: DateTime.now())
              .orderBy("datecomment")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Text("Please wait...");
              default:
                if (snapshot.hasData) {
                  print(snapshot.data!.docs.length);
                  if (snapshot.data!.docs.length == 0) {
                    return Text("No record Found");
                  } else {
                    return ListView.separated(
                      controller: controller,
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        String comment = snapshot.data!.docs[index]['comment'];
                        String emailcomment =
                            snapshot.data!.docs[index]['emailcomment'];
                        var rating = snapshot.data!.docs[index]['rating'];

                        return Container(
                          padding: const EdgeInsets.all(6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 35.0,
                                    width: 35.0,
                                    margin: EdgeInsets.only(right: 8),
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
                                      '$emailcomment',
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.more_vert),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(
                                formattedDate(
                                    snapshot.data!.docs[index]["datecomment"]),
                                style: TextStyle(fontSize: 16.0),
                              ),
                              Row(
                                children: [
                                  SimpleStarRating(
                                    allowHalfRating: true,
                                    starCount: 5,
                                    rating: rating,
                                    size: 18.0,
                                  ),
                                  SizedBox(
                                    width: 16,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              GestureDetector(
                                child: isLess!
                                    ? Text(
                                        comment,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                      )
                                    : Text(
                                        comment,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)),
                                      ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(
                          thickness: 1,
                          color: Colors.grey,
                        );
                      },
                    );
                  }
                } else {
                  return Text("getting Error");
                }
            }
          }),
    );
  }

  String formattedDate(timestamp) {
    var datecomment =
        DateTime.fromMillisecondsSinceEpoch(timestamp.seconds * 1000);
    return DateFormat('dd-MM-yyyy hh:mm a').format(datecomment);
  }
}
