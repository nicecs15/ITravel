import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/utility/my_style.dart';

class Profile extends StatefulWidget {
  Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? displayName;
  String? email;
  @override
  void initState() {
    super.initState();
    findDisplayName();
  }

  Future<Null> findDisplayName() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          displayName = event!.displayName;
          email = event.email;
        });
        print('#### displayname = $displayName');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MyStyle().primaryColor,
          title: const Text('โปรไฟล์'),
        ),
        body: Center(
          child: Container(
            width: 250,
            height: 250,
            child: ListTile(
              leading: Icon(
                Icons.account_box_outlined,
                size: 62,
                color: MyStyle().darkColor,
              ),
              title: MyStyle()
                  .titleH2(displayName == null ? 'User ' : displayName!),
              subtitle: Text(email == null ? 'user email ' : email!),
            ),
          ),
        ));
  }
}
