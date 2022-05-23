import 'package:flutter/material.dart';
import 'package:myapp1/widget/addlist.dart';
import 'package:myapp1/widget/authen.dart';
import 'package:myapp1/widget/central_list.dart';
import 'package:myapp1/widget/isan_list.dart';
import 'package:myapp1/widget/like_list.dart';
import 'package:myapp1/widget/my_service.dart';
import 'package:myapp1/widget/north_list.dart';
import 'package:myapp1/widget/profile.dart';
import 'package:myapp1/widget/register.dart';
import 'package:myapp1/widget/south_list.dart';

final Map<String, WidgetBuilder> routes = {
  '/authen': (BuildContext context) => Authen(),
  '/register': (BuildContext context) => Register(),
  '/myService': (BuildContext context) => MyService(),
  '/north_list': (BuildContext context) => NorthList(),
  '/isan_list': (BuildContext context) => IsanList(),
  '/central_list': (BuildContext context) => CentralList(),
  '/south_list': (BuildContext context) => SouthList(),
  '/profile': (BuildContext context) => Profile(),
  '/like': (BuildContext context) => LikeList(),
  '/add': (BuildContext context) => AddList(),
};
