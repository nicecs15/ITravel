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
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.fromLTRB(10.0, 40.0, 10.0, 0.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.account_circle, size: 150.0),
            SizedBox(height: 20.0),
            Text('User Info',
                style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold)),
            Divider(),
            ListTile(
              leading: Text('Name', style: TextStyle(fontSize: 15.0)),
              trailing: Text(displayName == null ? 'user' : displayName!,
                  style: TextStyle(fontSize: 15.0)),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            ),
            Divider(),
            ListTile(
              leading: Text('Email', style: TextStyle(fontSize: 15.0)),
              trailing: Text(email == null ? 'email' : email!,
                  style: TextStyle(fontSize: 15.0)),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
