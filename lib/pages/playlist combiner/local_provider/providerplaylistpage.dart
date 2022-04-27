// ignore_for_file: file_names, avoid_print, unnecessary_null_comparison

import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:utube_playlist_combiner/models/PlaylistItem.dart';
import 'package:utube_playlist_combiner/services/utubeservice.dart';

import '../components/PlaylistFieldWidget.dart';

class ProviderPlaylist extends ChangeNotifier {
  final playlistInputFields =
      Queue<PlaylistFieldWidget>(); //Stores all the input fields

  ProviderPlaylist() {
    //Default Input field. index is 0 to signify it can't be deleted
    playlistInputFields.add(PlaylistFieldWidget(
      index: 0,
      url:
          "https://www.youtube.com/playlist?list=PLexo0oy2xb1JjsFn_rpbxVkFaRXEH3FU7",
    ));
  }

  ///Adds a new Playlist input field
  void addNew() {
    playlistInputFields.addLast(PlaylistFieldWidget(index: 1));
    notifyListeners();
  }

  ///Removes a playlist input field
  void remove(PlaylistFieldWidget widget) {
    playlistInputFields.remove(widget);
    notifyListeners();
  }

  @override
  void dispose() {
    var it = playlistInputFields.iterator;

    while (it.moveNext()) {
      try {
        it.current.tec.dispose();
      } catch (e) {
        print(e);
      }
    }
    super.dispose();
  }

  ///Gets all the songs from the playlist entered in the input fields
  Future<List<String?>> processPlaylist() async {
    var urls = []; //To store the raw urls from the [playlistInputFields]

    var playlistIDs = []; //To store the IDs extracted from the [urls]

    var iterator = playlistInputFields
        .iterator; //To iterate through the queue[playlistInputFields]

    while (iterator.moveNext()) {
      var playListInputField = iterator.current;

      if (playListInputField.tec.text.trim().isNotEmpty) {
        urls.add(playListInputField.tec.text.trim());
      }
    }

    if (urls.isEmpty) {
      throw Exception("No URL found");
    } //If no URLs found throw error

    //extract playlistID from the urls
    for (String s in urls) {
      if (s.trim().isEmpty) continue; //Safety check. Skip urls which are empty

      String id = ""; //Stores the playlist ID extracted from the URL

      id = s.replaceAll("https://", "");

      id = id.replaceAll("www.youtube.com/playlist?list=", "");

      id = id.replaceAll("youtube.com/playlist?list=", "");

      playlistIDs.add(id); //Adds the extracted playlistId[id] to [playlistIDs]
    }

    List<PlaylistItem> playlistItems =
        []; //To store the response object that we get after we call getPlaylistItem which is going to give us the information related to the playlist including the video

    for (String s in playlistIDs) {
      var firstItem = await UtubeService.getPlaylistItem(
          s); //Got the first playListItem and stored it in firstItem

      /*
      There may be more pages, and to handle we have the follow steps 
      */
      var firstItemchildren = await _getAllSongsFromPlaylist(firstItem, s,
          []); //stores a list of playlistItem that we got from this recursive function that is going to be called until we run out of next page token

      //Add firstItem to playlistItems
      playlistItems.add(firstItem);

      //Store firstItemChildren to playlistItems if they are not empty
      if (firstItemchildren.isNotEmpty) {
        for (PlaylistItem p in firstItemchildren) {
          playlistItems.add(p);
        }
      }
    }

    return _getSongsFromPlaylists(
        playlistItems); //Extracts the songs from the argument of type PlaylistItem and returns a list of string[videoIDs]
  }

  /*
    *A recursive function that is going to keep executing until the parameter[firstItem]  has it's variable [nextPageToken] null
    *It is going to store the result in the parameter [list] and then pass it to the next recursive call, this way we retain 
    *the records of the list no matter how deep we are in the recursive tree
    */
  Future<List<PlaylistItem>> _getAllSongsFromPlaylist(PlaylistItem firstItem,
      String playlistID, List<PlaylistItem> list) async {
    //Check if there is any nextPage
    if (firstItem.nextPageToken == null) {
      //No next page
      return list;
    }

    //Next page token exists so we need to get it
    var nextItem = await UtubeService.getPlaylistItem(playlistID,
        nextPageToken: firstItem.nextPageToken);
    //Adding the item we got into the [list]
    list.add(nextItem);

    //recursion call but we are passing the [nextItem] to check if the [nextItem] also has a nextPageToken
    return _getAllSongsFromPlaylist(nextItem, playlistID, list);
  }

  ///Extracts videoID from PlaylistItem and filters out the duplicates
  List<String?> _getSongsFromPlaylists(List<PlaylistItem> list) {
    List<String?> songs = [];

    for (PlaylistItem p in list) {
      List<Items>? a = p.items;
      //add all songs from list
      for (var s in a!) {
        if (songs.contains(s.contentDetails!.videoId)) {
          continue; //Video already exists in list so we do not add it. This is useful if playlist has two overlapping songs
        }
        songs.add(s.contentDetails!.videoId);
      }
    }
    return songs;
  }
}
