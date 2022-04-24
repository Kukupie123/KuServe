// ignore_for_file: file_names

import 'dart:collection';

import 'package:flutter/cupertino.dart';

import '../components/PlaylistFieldWidget.dart';

class ProviderHomePage extends ChangeNotifier {
  final playlist = Queue<PlaylistFieldWidget>();

  ProviderHomePage() {
    playlist.add(PlaylistFieldWidget(url: "", index: 0));
  }

  void addNew() {
    playlist.addLast(PlaylistFieldWidget(url: "", index: 1));
    notifyListeners();
  }

  void remove(PlaylistFieldWidget widget) {
    playlist.remove(widget);
    notifyListeners();
  }
}
