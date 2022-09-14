import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myapp1/utility/dialog.dart';
import 'package:myapp1/utility/my_style.dart';
import 'package:myapp1/widget/my_service.dart';
import 'package:myapp1/widget/south_list.dart';

class AddListNorth extends StatefulWidget {
  final String? name;
  final String? province;
  final String? detail;
  final String? urlPicture;

  const AddListNorth(
      {Key? key, this.name, this.detail, this.province, this.urlPicture})
      : super(key: key);

  @override
  State<AddListNorth> createState() => _AddListNorthState();
}

class _AddListNorthState extends State<AddListNorth> {
  File? file;
  String? name, province, detail, urlPicture;
  final formKey = GlobalKey<FormState>();
  /////////////////////////////
  Widget uploadButton() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            child: RaisedButton.icon(
              color: MyStyle().primaryColor,
              onPressed: () {
                if (file == null) {
                  showAlert('โปรดทำการเลือกรูปภาพสถานที่ท่องเที่ยว',
                      'กรุณาเลือกรูปภาพ');
                } else if (name == null ||
                    name!.isEmpty ||
                    province == null ||
                    province!.isEmpty ||
                    detail == null ||
                    detail!.isEmpty) {
                  showAlert(
                      'โปรดกรอกข้อมูลสถานที่ท่องเที่ยว', 'กรอกข้อมูลให้ครบ');
                } else {
                  // upload value to firebase
                  uploadPictureToStorage();
                }
              },
              icon: Icon(Icons.add, color: Colors.white),
              label: Text(
                'เพิ่มข้อมูลสถานที่',
                style: TextStyle(color: Colors.white),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> showAlert(String title, String message) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                )
              ]);
        });
  }

  Future<void> uploadPictureToStorage() async {
    Random random = Random();
    int i = random.nextInt(100000);

    FirebaseStorage firebaseStorage = FirebaseStorage.instance;
    Reference storageReference =
        firebaseStorage.ref().child('imgnorth/imgnorth$i.jpg');
    UploadTask storageUploadTask = storageReference.putFile(file!);

    urlPicture = await (await storageUploadTask).ref.getDownloadURL();
    print('urlPicture = $urlPicture');
    insertValueToFireStore(name);
  }

  Future<void> insertValueToFireStore(name) async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    Map<String, dynamic> map = Map();
    map['name'] = name;
    map['province'] = province;
    map['detail'] = detail;
    map['img'] = urlPicture;

    await firebaseFirestore
        .collection('north')
        .doc(name)
        .set(map)
        .then((value) {
      print("addlistnorth");
      Navigator.pop(context, '/north_list');
    });
  }

  Widget nameForm() {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: TextFormField(
          onChanged: (String string) {
            name = string.trim();
          },
          decoration: InputDecoration(
            labelText: 'ชื่อสถานที่',
            icon: Icon(Icons.map),
          ),
        ));
  }

  Widget provinceForm() {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: TextFormField(
          onChanged: (String value) {
            province = value.trim();
          },
          decoration: InputDecoration(
            labelText: 'จังหวัดสถานที่',
            icon: Icon(Icons.place),
          ),
        ));
  }

  Widget detailForm() {
    return SizedBox(
        width: MediaQuery.of(context).size.width * 0.6,
        child: TextFormField(
          onChanged: (String value) {
            detail = value.trim();
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
          color: Colors.green,
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
          color: Colors.red,
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
            provinceForm(),
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
        title: Text('เพิ่มสถานที่ท่องเที่ยว'),
      ),
      body: SingleChildScrollView(
        child: Wrap(
          children: [
            showContent(),
            uploadButton(),
          ],
        ),
      ),
    );
  }
}