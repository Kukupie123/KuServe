// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:utube_playlist_combiner/models/PlaylistItem.dart';
import 'package:utube_playlist_combiner/models/VideoItem.dart';

/*
 * curl \
  'https://youtube.googleapis.com/youtube/v3/playlistItems?part=contentDetails&playlistId=PLfJxOs8CS6Bsr6opEuSQcm_iAvAQvMexx&access_token=AIzaSyAEnBieHIcJcqNJld9EYw6Ov8nzVJGh7Fg&key=[YOUR_API_KEY]' \
  --header 'Accept: application/json' \
  --compressed
 */

/*
 * curl \
  'https://youtube.googleapis.com/youtube/v3/videos?part=snippet%2CcontentDetails%2Cstatistics&id=UkEA5cSYgdE&access_token=AIzaSyAEnBieHIcJcqNJld9EYw6Ov8nzVJGh7Fg&key=[YOUR_API_KEY]' \
  --header 'Accept: application/json' \
  --compressed

 */

class UtubeService {
  static const _baseUrl = "www.googleapis.com";
  static const _key = "AIzaSyAEnBieHIcJcqNJld9EYw6Ov8nzVJGh7Fg";

  static Future<PlaylistItem> getPlaylistItem(String playlistID) async {
    Map<String, String> parameters = {
      'part': 'contentDetails',
      'playlistId': playlistID,
      'key': _key
    };
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json"
    };

    Uri uri = Uri.https(_baseUrl, "/youtube/v3/playlistItems", parameters);

    var resp = await http.get(uri, headers: header);
    if (resp.statusCode != 200) throw Exception(resp.statusCode.toString());
    PlaylistItem playlistItem = PlaylistItem.fromJson(json.decode(resp.body));
    return playlistItem;
  }

  static Future<dynamic> getVideoItemFromSong(String? id) async {
    String newID = "";
    if (id != null) newID = id;
    Map<String, String> parameters = {
      'part': 'snippet,contentDetails,statistics',
      'id': newID,
      'key': _key
    };
    Map<String, String> header = {
      HttpHeaders.contentTypeHeader: "application/json"
    };
    Uri uri = Uri.https(_baseUrl, "/youtube/v3/videos", parameters);
    var resp = await http.get(uri, headers: header);

    if (resp.statusCode != 200)
      // ignore: curly_braces_in_flow_control_structures
      throw Exception('''
Get video from song status exception ''' +
          resp.statusCode.toString());

    print(json.decode(resp.body.toString()));

    VideoItem videoItem = VideoItem.fromJson(json.decode(resp.body));

    return videoItem;
    //TODO:FIX
  }
}
