// ignore_for_file: file_names, avoid_print

import 'dart:collection';

import 'package:flutter/cupertino.dart';
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

  void search() async {
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

    //Now we have urls of all entered playlist
    var a = await UtubeService.getSongsFromPlaylist(playlistIDs[0]);

    print(a.items![0].contentDetails!.videoPublishedAt.toString());
  }
}
