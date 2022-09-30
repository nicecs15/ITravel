import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/model/addlist_isan.dart';
import 'package:myapp1/utility/my_style.dart';
import 'package:myapp1/widget/authen.dart';
import 'package:myapp1/widget/isandetail.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'FavIsanDetail.dart';

class FavIsanList extends StatefulWidget {
  const FavIsanList({Key? key}) : super(key: key);

  @override
  State<FavIsanList> createState() => _FavIsanListState();
}

class _FavIsanListState extends State<FavIsanList> {
  var inputText = "";
  navigateToDetail(DocumentSnapshot isan) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => IsanDetail(isan: isan)));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: const Text('สถานที่ท่องเที่ยวในภาคอีสาน'),
      ),
      body: Column(children: [
        SizedBox(
          height: size.height / 30,
        ),
        Container(
          height: size.height / 14,
          width: size.width,
          alignment: Alignment.center,
          child: SizedBox(
            height: size.height / 14,
            width: size.width / 1.15,
            child: TextField(
                decoration: InputDecoration(
                    hintText: "ค้นหาสถานที่ท่องเที่ยว",
                    hintStyle: TextStyle(
                      color: Colors.black.withAlpha(120),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(color: Colors.black)),
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Colors.purple.shade800),
                onChanged: ((val) {
                  setState(() {
                    inputText = val;
                    print(inputText);
                  });
                })),
          ),
        ),
        Expanded(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("isan")
                  .where("name", isGreaterThanOrEqualTo: inputText)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Text("Loading"),
                  );
                }
                return ListView(
                  children: snapshot.data!.docs.map((document) {
                    return Card(
                        margin: EdgeInsets.all(6),
                        elevation: 3,
                        child: ListTile(
                            leading: ConstrainedBox(
                              constraints: BoxConstraints(
                                minWidth: 102,
                                minHeight: 56,
                                maxWidth: 102,
                                maxHeight: 56,
                              ),
                              child: Image.network(document["img"],
                                  fit: BoxFit.cover),
                            ),
                            title: Text(document["name"]),
                            subtitle: Text(document["province"]),
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return FavIsanDetail(
                                  isan: document,
                                );
                              }));
                            }));
                  }).toList(),
                );
              }),
        ),
      ]),

      //////////// addproto
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onAlertButtonsPressed(context),
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
      ),
    );
  }
}

_onAlertButtonsPressed(BuildContext context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "โปรดสมัครสมาชิกเพื่อเข้าสู่ระบบ",
    buttons: [
      DialogButton(
        child: Text(
          "ใช้งานต่อไป",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () => Navigator.pop(context),
        color: Color.fromRGBO(0, 179, 134, 1.0),
      ),
      DialogButton(
        child: Text(
          "เข้าสู่ระบบ",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
        onPressed: () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => Authen())),
        gradient: LinearGradient(colors: [
          Color.fromRGBO(116, 116, 191, 1.0),
          Color.fromRGBO(52, 138, 199, 1.0),
        ]),
      )
    ],
  ).show();
}
