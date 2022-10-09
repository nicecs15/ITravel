import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/FAV/FavNorthDetail.dart';
import 'package:myapp1/model/addlist_north.dart';
import 'package:myapp1/utility/my_style.dart';
import 'package:myapp1/widget/authen.dart';
import 'package:myapp1/widget/detail.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class FavNorthList extends StatefulWidget {
  const FavNorthList({Key? key}) : super(key: key);

  @override
  State<FavNorthList> createState() => _FavNorthListState();
}

class _FavNorthListState extends State<FavNorthList> {
  var inputText = "";
  navigateToDetail(DocumentSnapshot north) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => NorthDetail(north: north)));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: const Text('สถานที่ท่องเที่ยวในภาคเหนือ'),
      ),
      body: Column(
        children: [
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
                    .collection("Travel")
                    .where("north", isGreaterThanOrEqualTo: inputText)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
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
                          margin: const EdgeInsets.all(6),
                          elevation: 3,
                          child: ListTile(
                              leading: ConstrainedBox(
                                constraints: const BoxConstraints(
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
                                  return FavNorthDetail(
                                    north: document,
                                  );
                                }));
                              }));
                    }).toList(),
                  );
                }),
          )
        ],
      ),

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
