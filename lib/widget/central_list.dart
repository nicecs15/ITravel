import 'package:flutter/material.dart';

class CentralList extends StatefulWidget {
  const CentralList({Key? key}) : super(key: key);

  @override
  State<CentralList> createState() => _CentralListState();
}

class _CentralListState extends State<CentralList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text('this is Central'),
    );
  }
}
