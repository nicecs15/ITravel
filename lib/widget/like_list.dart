import 'package:flutter/material.dart';

class LikeList extends StatefulWidget {
  const LikeList({Key? key}) : super(key: key);

  @override
  State<LikeList> createState() => _LikeListState();
}

class _LikeListState extends State<LikeList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('like'),
    );
  }
}
