import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/utility/my_style.dart';
import 'package:myapp1/widget/central_list.dart';
import 'package:myapp1/widget/isan_list.dart';
import 'package:myapp1/widget/like_list.dart';
import 'package:myapp1/widget/homepage.dart';
import 'package:myapp1/widget/north_list.dart';
import 'package:myapp1/widget/profile.dart';
import 'package:myapp1/widget/south_list.dart';

class MyService extends StatefulWidget {
  const MyService({Key? key}) : super(key: key);

  @override
  State<MyService> createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  String? name, email;

  Widget currentWidget = Homepage();

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
          currentWidget = Homepage();
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
        onTap: () => Navigator.pushNamed(context, '/like'));
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
          title: MyStyle().titleH2White('ออกจากระบบ'),
        ),
      ],
    );
  }
}
