import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/utility/dialog.dart';
import 'package:myapp1/utility/my_style.dart';
import 'package:myapp1/widget/homepage.dart';
import 'package:myapp1/widget/my_service.dart';

class Authen extends StatefulWidget {
  const Authen({Key? key}) : super(key: key);

  @override
  State<Authen> createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  late double screen;
  bool statusRedEye = true;
  String? email, password;

  get currentUserReference => null;

  get initialPage => null;

  @override
  Widget build(BuildContext context) {
    screen = MediaQuery.of(context).size.width;
    print('screen = $screen');
    return Scaffold(
      floatingActionButton: buildRegister(),
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
              center: Alignment(0, -0.30),
              radius: 1.3,
              colors: <Color>[Colors.white, MyStyle().primaryColor]),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildLogo(),
              MyStyle().titleH1('ITravel'),
              buildUser(),
              buildPassword(),
              buildLogin(),
              buildGetStarted(),
            ],
          ),
        ),
      ),
    );
  }

  TextButton buildRegister() {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, '/register'),
      child: Text(
        'สร้างบัญชีผู้ใช้ใหม่',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Container buildLogin() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * .75,
      child: ElevatedButton(
        onPressed: () {
          if ((email == null) || (password == null)) {
            normalDialog(context, 'โปรดกรอกข้อมูลให้ครบ');
          } else {
            checkAuthen();
          }
        },
        child: Text('เข้าสู่ระบบ'),
        style: ElevatedButton.styleFrom(
          primary: MyStyle().darkColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Container buildGetStarted() {
    return Container(
      margin: EdgeInsets.only(top: 16),
      width: screen * .75,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return MyService();
          }));
        },
        child: Text('ใช้งานไม่ระบุตัวตน'),
        style: ElevatedButton.styleFrom(
          primary: MyStyle().darkColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }

  Container buildUser() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: Colors.white60),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: TextFormField(
        keyboardType: TextInputType.emailAddress,
        onChanged: (value) => email = value.trim(),
        style: TextStyle(
          color: MyStyle().darkColor,
        ),
        decoration: InputDecoration(
          labelStyle: TextStyle(color: MyStyle().darkColor),
          labelText: 'อีเมล',
          prefixIcon: Icon(
            Icons.perm_identity,
            color: MyStyle().darkColor,
          ),
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
        borderRadius: BorderRadius.circular(25),
        color: Colors.white60,
      ),
      margin: EdgeInsets.only(top: 16),
      width: screen * 0.75,
      child: TextFormField(
        onChanged: (value) => password = value.trim(),
        obscureText: statusRedEye,
        style: TextStyle(
          color: MyStyle().darkColor,
        ),
        decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: statusRedEye
                ? Icon(Icons.remove_red_eye)
                : Icon(Icons.remove_red_eye_outlined),
            onPressed: () {
              setState(() {
                statusRedEye = !statusRedEye;
              });

              print('statusRedEye = $statusRedEye');
            },
          ),
          labelStyle: TextStyle(color: MyStyle().darkColor),
          labelText: 'รหัสผ่าน',
          prefixIcon: Icon(
            Icons.lock_outline,
            color: MyStyle().darkColor,
          ),
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

  Container buildLogo() {
    return Container(
      width: screen * 0.4,
      child: MyStyle().showLogo(),
    );
  }

  Future<void> checkAuthen() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email ?? '', password: password ?? '')
          .then((value) => Navigator.pushNamedAndRemoveUntil(
              context, '/myService', (route) => false))
          .catchError((value) => normalDialog(context, value.message));
    });
  }
}

NavBarPage({required String initialPage}) {}

class BudgetListRecord {
  static var collection;
}

createBudgetListRecordData({budgetUser}) {}

signInAnonymously(BuildContext context) {}
