import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp1/notifier/north_notifier.dart';
import 'package:myapp1/router.dart';

String initialRoute = '/authen';

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().then((value) async {});
  await FirebaseAuth.instance.authStateChanges().listen((event) {
    if (event != null) {
      initialRoute = '/myService';
    }
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: initialRoute,
      title: 'ITravel',
    );
  }
}
