import 'package:flutter/material.dart';
import 'package:myapp1/anonymous.dart/favorliteany.dart';
import 'package:myapp1/model/addlist_central.dart';
import 'package:myapp1/model/addlist_isan.dart';
import 'package:myapp1/model/addlist_north.dart';
import 'package:myapp1/model/addlist_south.dart';
import 'package:myapp1/widget/authen.dart';
import 'package:myapp1/widget/central_list.dart';
import 'package:myapp1/widget/detail.dart';
import 'package:myapp1/widget/isan_list.dart';
import 'package:myapp1/widget/like_list.dart';
import 'package:myapp1/widget/my_service.dart';
import 'package:myapp1/widget/north_list.dart';
import 'package:myapp1/widget/profile.dart';
import 'package:myapp1/widget/register.dart';
import 'package:myapp1/widget/south_list.dart';
import 'package:myapp1/widget/southdetail.dart';

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
  '/add_north': (BuildContext context) => AddListNorth(),
  '/add_isan': (BuildContext context) => AddListIsan(),
  '/add_central': (BuildContext context) => AddListCentral(),
  '/add_south': (BuildContext context) => AddListSouth(),
};
