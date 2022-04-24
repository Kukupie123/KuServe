// ignore_for_file: file_names, avoid_print, unnecessary_null_comparison

import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:utube_playlist_combiner/models/PlaylistItem.dart';
import 'package:utube_playlist_combiner/services/utubeservice.dart';

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

  Future<List<String?>> processPlaylist() async {
    var urls = [];
    var playlistIDs = [];
    var iterator = playlist.iterator;

    while (iterator.moveNext()) {
      var p = iterator.current;

      if (p.tec.text.trim().isNotEmpty) {
        urls.add(p.tec.text.trim());
      }
    }

    //extract playlistID from the urls
    for (String s in urls) {
      //https://www.youtube.com/playlist?list=PLfJxOs8CS6Bsr6opEuSQcm_iAvAQvMexx
      String id = s.replaceAll("https://", "");
      id = id.replaceAll("www.youtube.com/playlist?list=", "");
      playlistIDs.add(id);
    }

    //Store object in a list
    List<PlaylistItem> playlistItems = [];

    for (String s in playlistIDs) {
      var a = await UtubeService.getPlaylistItem(s);
      playlistItems.add(a);
    }

    //get all songs from all playlistitems
    return _getSongsFromPlaylists(playlistItems);
  }

  List<String?> _getSongsFromPlaylists(List<PlaylistItem> list) {
    List<String?> songs = [];

    for (PlaylistItem p in list) {
      List<Items>? a = p.items;
      //add all songs from list
      for (var s in a!) {
        songs.add(s.contentDetails!.videoId);
      }
    }
    return songs;
  }
}
