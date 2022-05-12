import 'package:cloud_firestore/cloud_firestore.dart';

class North {
  String? name;
  String? detail;
  String? image;
  Timestamp? createdAt;

  North();

  Map<String, dynamic> toJson() =>
      {'name': name, 'detail': detail, 'image': image, 'createAt': createdAt};

  North.fromSnapshot(snapshot)
      : name = snapshot.data()['name'],
        detail = snapshot.data()['detail'],
        image = snapshot.data()['image'],
        createdAt = snapshot.data()['createdAt'].toDate();
}
