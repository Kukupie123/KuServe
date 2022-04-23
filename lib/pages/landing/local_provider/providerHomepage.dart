import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:youtube_playlist_combiner/pages/landing/components/PlaylistFieldWidget.dart';

class ProviderHomePage with ChangeNotifier {
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
