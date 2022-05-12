import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/utility/dialog.dart';
import 'package:myapp1/utility/my_style.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late double screen;
  late String name, email, password;

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    return Scaffold(
      //floatingActionButton: buildFloatingActionButton(),
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: Text('สร้างบัญชีผู้ใช้'),
      ),
      body: Center(
        child: Column(
          children: [
            buildLogo(),
            buildName(),
            buildEmail(),
            buildPassword(),
            buildRegister(),
          ],
        ),
      ),
    );
  }

  Container buildLogo() {
    return Container(
      margin: EdgeInsets.only(top: 30),
      width: screen * 0.4,
      child: MyStyle().showLogo(),
    );
  }

  Container buildRegister() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * .75,
      child: ElevatedButton(
        onPressed: () {
          print('name = $name, email = $email, password = $password');
          if ((name == null) || (email == null) || (password == null)) {
            print('Have Space');
            normalDialog(context, 'โปรดกรอกข้อมูล');
          } else {
            print('No Space');
            registerFirebase();
          }
        },
        child: Text('สมัครสมาชิก'),
        style: ElevatedButton.styleFrom(
          primary: MyStyle().darkColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Container buildName() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.white60),
      margin: EdgeInsets.only(top: 20),
      width: screen * 0.75,
      child: TextField(
        onChanged: (value) => name = value.trim(),
        style: TextStyle(
          color: MyStyle().darkColor,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          hintText: '  ชื่อผู้ใช้ :',
          /*prefixIcon: Icon(
            Icons.fingerprint,
            color: MyStyle().darkColor,
          ),*/
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: MyStyle().darkColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildEmail() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.white60),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) => email = value.trim(),
        style: TextStyle(
          color: MyStyle().darkColor,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          hintText: '  อีเมล :',
          /*prefixIcon: Icon(
            Icons.perm_identity,
            color: MyStyle().darkColor,
          ),*/
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: MyStyle().darkColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Container buildPassword() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.white60),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        style: TextStyle(
          color: MyStyle().darkColor,
        ),
        decoration: InputDecoration(
          hintStyle: TextStyle(color: MyStyle().darkColor),
          hintText: '  รหัสผ่าน :',
          /*prefixIcon: Icon(
            Icons.lock_outline,
            color: MyStyle().darkColor,
          ),*/
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: MyStyle().darkColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(color: MyStyle().lightColor),
          ),
        ),
      ),
    );
  }

  Future<void> registerFirebase() async {
    await Firebase.initializeApp().then((value) async {
      print('Firebase Initialize Success');
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        print('Register Success');
        // ignore: deprecated_member_use
        await value.user?.updateProfile(displayName: name).then((value) =>
            Navigator.pushNamedAndRemoveUntil(
                context, '/myService', (route) => false));
      }).catchError((value) {
        normalDialog(context, value.message);
      });
    });
  }
}
