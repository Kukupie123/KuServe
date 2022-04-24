// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:utube_playlist_combiner/services/utubeservice.dart';
import 'package:utube_playlist_combiner/models/VideoItem.dart';

class ProviderCombined with ChangeNotifier {
  List<String>? songsIDs;

  List<ItemVideo>? itemVideos;

  void _updateVideoItems(List<ItemVideo> items) {
    itemVideos = items;
    notifyListeners();
  }

  void getVideoItemsFromSongs() async {
    List<ItemVideo> items = [];
    for (String s in songsIDs!) {
      var a = await UtubeService.getVideoItemFromSong(s);
      items.add(a.items[0]);
    }
    _updateVideoItems(items);
  }
}
