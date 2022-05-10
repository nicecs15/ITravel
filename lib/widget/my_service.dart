import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/utility/my_style.dart';
import 'package:myapp1/widget/central_list.dart';
import 'package:myapp1/widget/isan_list.dart';
import 'package:myapp1/widget/like_list.dart';
import 'package:myapp1/widget/%E0%B9%89homepage.dart';
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
        title: Text('รีวิวและแนะนำสถานที่ท่องเที่ยว'),
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
              buildListTileNorthList(),
              buildListTileIsanList(),
              buildListTileCentralList(),
              buildListTileSouthList(),
              buildListTileLikeList(),
            ],
          ),
          buildSignOut(),
        ],
      ),
    );
  }

  ListTile buildListTileNorthList() {
    return ListTile(
      leading: Icon(
        Icons.home,
        size: 28,
        color: Colors.red,
      ),
      title: MyStyle().titleH3('ภาคเหนือ'),
      subtitle: Text('รวมสถานที่ท่องเที่ยวในภาคเหนือ'),
      onTap: () {
        setState(() {
          currentWidget = NorthList();
        });
        Navigator.pop(context);
      },
    );
  }

  ListTile buildListTileIsanList() {
    return ListTile(
      leading: Icon(
        Icons.home,
        size: 28,
        color: Colors.red,
      ),
      title: MyStyle().titleH3('ภาคอีสาน'),
      subtitle: Text('รวมสถานที่ท่องเที่ยวในภาคอีสาน'),
      onTap: () {
        setState(() {
          currentWidget = IsanList();
        });
        Navigator.pop(context);
      },
    );
  }

  ListTile buildListTileCentralList() {
    return ListTile(
      leading: Icon(
        Icons.home,
        size: 28,
        color: Colors.red,
      ),
      title: MyStyle().titleH3('ภาคกลาง'),
      subtitle: Text('รวมสถานที่ท่องเที่ยวในภาคกลาง'),
      onTap: () {
        setState(() {
          currentWidget = CentralList();
        });
        Navigator.pop(context);
      },
    );
  }

  ListTile buildListTileSouthList() {
    return ListTile(
      leading: Icon(
        Icons.home,
        size: 28,
        color: Colors.red,
      ),
      title: MyStyle().titleH3('ภาคใต้'),
      subtitle: Text('รวมสถานที่ท่องเที่ยวในภาคใต้'),
      onTap: () {
        setState(() {
          currentWidget = SouthList();
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
      subtitle: Text('รวมสถานที่ท่องเที่ยวที่คุณชื่นชอบ'),
      onTap: () {
        setState(() {
          currentWidget = LikeList();
        });
        Navigator.pop(context);
      },
    );
  }

//head
  UserAccountsDrawerHeader buildUserAccountsDrawerHeader() {
    return UserAccountsDrawerHeader(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/wall.png'), fit: BoxFit.cover),
        ),
        accountName: MyStyle().titleH2White(name ?? 'Name'),
        accountEmail: MyStyle().titleH3White(email ?? 'Email'),
        currentAccountPicture: IconButton(
          icon: Image.asset('images/traveller.png'),
          onPressed: () {
            setState(() {
              currentWidget = Profile();
            });
            Navigator.pop(context);
          },
        ) /*Image.asset('images/traveller.png')*/
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
