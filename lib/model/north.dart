import 'package:cloud_firestore/cloud_firestore.dart';

class North {
  String Name;
  String Detail;
  String PathImage;
  Timestamp Time;

  North.fromMap(Map<String, dynamic> data) {
    Name = data['Name'];
    Detail = data['Detail'];
    PathImage = data['Image'];
    Time = data['Time'];
  }
}
