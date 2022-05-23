import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp1/utility/dialog.dart';
import 'package:myapp1/utility/my_style.dart';

class AddList extends StatefulWidget {
  const AddList({Key? key}) : super(key: key);

  @override
  State<AddList> createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  File? file;
  String? name, detail;
  final formKey = GlobalKey<FormState>();
  /////////////////////////////
  Widget uploadButton() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.6,
            child: RaisedButton.icon(
                color: MyStyle().primaryColor,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (file == null) {
                      normalDialog(context, 'กรุณาเลือกรูปภาพ');
                    }
                  } else {}
                },
                icon: Icon(Icons.add, color: Colors.white),
                label: Text(
                  'เพิ่มข้อมูลสถานที่',
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ],
      ),
    );
  }

  Future<void> uploadPicture() async {}

  Future<void> insertValueToFireStore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    Map<String, dynamic> map = Map();
    map['name'] = name;
    map['detail'] = detail;
    //map['img'] =

    await firebaseFirestore.collection('isan').doc().set(map).then((value) {
      print('เย้');
    });
  }

  Widget nameForm() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอกชื่อสถานที่';
            } else {}
          },
          onChanged: (String string) {
            name = string.trim();
          },
          decoration: InputDecoration(
            labelText: 'ชื่อสถานที่',
            icon: Icon(Icons.place),
          ),
        ));
  }

  Widget detailForm() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: TextFormField(
          validator: (value) {
            if (value!.isEmpty) {
              return 'กรุณากรอกลายละเอียด';
            } else {}
          },
          onChanged: (String string) {
            detail = string.trim();
          },
          decoration: InputDecoration(
            labelText: 'รายละเอียด',
            icon: Icon(Icons.details),
          ),
        ));
  }

  Widget cameraButton() {
    return IconButton(
        onPressed: () {
          chooseImage(ImageSource.camera);
        },
        icon: Icon(
          Icons.add_a_photo,
          size: 36.0,
        ));
  }

  Future<void> chooseImage(ImageSource source) async {
    try {
      var result = await ImagePicker()
          .getImage(source: source, maxWidth: 800, maxHeight: 800);

      setState(() {
        file = File(result!.path);
      });
    } catch (e) {}
  }

  Widget galleryButton() {
    return IconButton(
        onPressed: () {
          chooseImage(ImageSource.gallery);
        },
        icon: Icon(
          Icons.add_photo_alternate,
          size: 36.0,
        ));
  }

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [cameraButton(), galleryButton()],
    );
  }

  Widget showImage() {
    return Container(
      padding: EdgeInsets.all(20.0),
      //color: Colors.grey,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      child: file == null ? Image.asset('images/pic.png') : Image.file(file!),
    );
  }

  Widget showContent() {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            showImage(),
            showButton(),
            nameForm(),
            detailForm(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: Text('add'),
      ),
      body: Container(
        child: Stack(
          children: [
            showContent(),
            uploadButton(),
          ],
        ),
      ),
    );
  }
}
