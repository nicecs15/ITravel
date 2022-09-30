import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/anonymous.dart/favorliteany.dart';
import 'package:myapp1/utility/my_style.dart';
import 'package:myapp1/widget/homepage.dart';

import '../FAV/FavHomepage.dart';

class MyServiceAny extends StatefulWidget {
  const MyServiceAny({Key? key}) : super(key: key);

  @override
  State<MyServiceAny> createState() => _MyServiceAnyState();
}

class _MyServiceAnyState extends State<MyServiceAny> {
  String? name, email;

  Widget currentWidget = FavHomepage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    findNameAndEmail();
  }

  Future<void> findNameAndEmail() async {
    await Firebase.initializeApp().then((value) async {
      await FirebaseAuth.instance.authStateChanges().listen((event) {
        setState(() {
          name = event!.displayName;
          email = event.email;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyStyle().primaryColor,
        title: Text('หน้าหลัก'),
      ),
      drawer: buildDrawer(),
      body: currentWidget,
    );
  }

  Drawer buildDrawer() {
    return Drawer(
      child: Stack(
        children: [
          Column(
            children: [
              buildUserAccountsDrawerHeader(),
              buildListTileHomePage(),
              buildListTileLikeList(),
            ],
          ),
          buildSignOut(),
        ],
      ),
    );
  }

  ListTile buildListTileHomePage() {
    return ListTile(
      leading: Icon(
        Icons.home,
        size: 28,
        color: Colors.red,
      ),
      title: MyStyle().titleH3('หน้าหลัก'),
      onTap: () {
        setState(() {
          currentWidget = FavHomepage();
        });
        Navigator.pop(context);
      },
    );
  }

  ListTile buildListTileLikeList() {
    return ListTile(
        leading: Icon(
          Icons.favorite,
          size: 28,
          color: Colors.red,
        ),
        title: MyStyle().titleH3('สถานที่ท่องเที่ยวที่ชื่นชอบ'),
        onTap: () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => FavAny())));
  }

  ListTile buildListTileAddList() {
    return ListTile(
        leading: Icon(
          Icons.add,
          size: 28,
          color: Colors.red,
        ),
        title: MyStyle().titleH3('add'),
        onTap: () => Navigator.pushNamed(context, '/add'));
  }

//head
  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/wall.png'), fit: BoxFit.cover),
        ),
        accountName: MyStyle().titleH2White(name ?? 'ไม่ระบุตัวตน'),
        accountEmail: MyStyle().titleH3White(email ?? ''),
        currentAccountPicture: IconButton(
            icon: Image.asset('images/traveller.png'),
            onPressed: () => Navigator.pushNamed(
                context, '/profile')) /*Image.asset('images/traveller.png')*/
        );
  }

  Column buildSignOut() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ListTile(
          onTap: () async {
            await Firebase.initializeApp().then((value) async {
              await FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/authen', (route) => false));
            });
          },
          tileColor: MyStyle().darkColor,
          leading: Icon(
            Icons.exit_to_app,
            color: Colors.white,
            size: 36,
          ),
          title: MyStyle().titleH2White('เข้าสู่ระบบ'),
        ),
      ],
    );
  }
}
