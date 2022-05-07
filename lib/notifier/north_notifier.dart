import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:myapp1/model/north.dart';

class NorthNotifier with ChangeNotifier {
  List<North> _northList = [];
  North _currentNorth;

  UnmodifiableListView<North> get northList => UnmodifiableListView(_northList);

  North get currentNorth => _currentNorth;

  set northList(List<North> northList) {
    _northList = northList;
    notifyListeners();
  }

  set currentNorth(North north) {
    _currentNorth = north;
    notifyListeners();
  }
}
