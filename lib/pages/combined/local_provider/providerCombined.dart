// ignore_for_file: file_names, unused_local_variable, unnecessary_null_comparison

import 'package:flutter/cupertino.dart';
import 'package:utube_playlist_combiner/models/MinimalVideo.dart';
import 'package:utube_playlist_combiner/services/utubeservice.dart';

class ProviderCombined with ChangeNotifier {
  late List<String?> songsIDs = [];

  List<MinimalVideoItem>? itemVideos;

  void _updateVideoItems(List<MinimalVideoItem> items) {
    itemVideos = items;
    notifyListeners();
  }

  void getVideoItemsFromSongs() async {
    List<MinimalVideoItem> items = [];

    print("SONGS ::: " + songsIDs.toString());

    int length = 0;
    length = songsIDs.length;
    for (int i = 0; i < length; i++) {
      var a = await UtubeService.getVideoItemFromSong(songsIDs[i]!);
      items.add(a);
    }
    _updateVideoItems(items);
  }
}
