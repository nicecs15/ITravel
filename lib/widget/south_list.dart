import 'package:flutter/material.dart';

class SouthList extends StatefulWidget {
  const SouthList({Key? key}) : super(key: key);

  @override
  State<SouthList> createState() => _SouthListState();
}

class _SouthListState extends State<SouthList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('this is south'),
    );
  }
}
