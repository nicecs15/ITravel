import 'package:flutter/material.dart';
import 'package:myapp1/widget/authen.dart';
import 'package:myapp1/widget/my_service.dart';
import 'package:myapp1/widget/register.dart';

final Map<String, WidgetBuilder> routes = {
  '/authen': (BuildContext context) => Authen(),
  '/register': (BuildContext context) => Register(),
  '/myService': (BuildContext context) => MyService(),
};
