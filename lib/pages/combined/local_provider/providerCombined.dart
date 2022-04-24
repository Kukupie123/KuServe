// ignore_for_file: file_names, unused_local_variable, unnecessary_null_comparison

import 'package:flutter/cupertino.dart';
import 'package:utube_playlist_combiner/services/utubeservice.dart';
import 'package:utube_playlist_combiner/models/VideoItem.dart';

class ProviderCombined with ChangeNotifier {
  late List<String?> songsIDs = [];

  List<Item>? itemVideos;

  void _updateVideoItems(List<Item> items) {
    itemVideos = items;
    notifyListeners();
  }

  void getVideoItemsFromSongs() async {
    List<Item> items = [];

    print("SONGS ::: " + songsIDs.toString());

    int length = 0;
    length = songsIDs.length;
    for (int i = 0; i < length; i++) {
      var a = await UtubeService.getVideoItemFromSong(songsIDs[i]);
      items.add(a.items[0]);
    }
    _updateVideoItems(items);
  }
}
