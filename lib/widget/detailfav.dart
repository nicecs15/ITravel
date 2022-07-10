import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/utility/my_style.dart';

class DetailFav extends StatefulWidget {
  DetailFav({Key? key, required DocumentSnapshot<Object?> north})
      : super(key: key);

  @override
  State<DetailFav> createState() => _DetailFavState();
}

class _DetailFavState extends State<DetailFav> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: const Text('สถานที่ท่องเที่ยว'),
      ),
    );
  }
}
