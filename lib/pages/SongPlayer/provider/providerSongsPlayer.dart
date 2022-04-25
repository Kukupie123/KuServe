// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';

class ProviderSongsPlayer with ChangeNotifier {
  List<String> _songIDs = [];

  void updateSongs(List<String> songs) {
    _songIDs = songs;
    notifyListeners();
  }
}
