// ignore_for_file: avoid_unnecessary_containers, prefer_final_fields, file_names, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:utube_playlist_combiner/pages/HomePage/servicesPage/PageServices.dart';

class ProviderHome with ChangeNotifier {
  int _indx = 0;
  List<Widget> _views = [
    Pageservice(),
    Container(
      child: Text("WIP"),
    )
  ];

  void updateIndex(int i) {
    if (i >= _views.length) return;
    _indx = i;
    notifyListeners();
  }

  Widget getView() {
    return _views[_indx];
  }
}
