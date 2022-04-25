// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:utube_playlist_combiner/models/MinimalVideo.dart';
import 'package:utube_playlist_combiner/models/PlaylistItem.dart';

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

    var resp = await http.get(uri, headers: header).catchError((e) {
      throw Exception(e.toString());
    });

    if (resp.statusCode != 200) {
      if (resp.statusCode == 404) {
        throw Exception("Playlist with ID ${playlistID} not found!");
      }
      throw Exception(json.decode(resp.body)['error']['message']);
    }

    PlaylistItem playlistItem = PlaylistItem.fromJson(json.decode(resp.body));

    return playlistItem;
  }

  static Future<MinimalVideoItem> getVideoItemFromSong(String id) async {
    Map<String, String> parameters = {
      'part': 'snippet,contentDetails,statistics',
      'id': id,
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

    var mapped = json.decode(resp.body);

    var item = mapped['items'][0];

    String desc = item['snippet']['description'];
    String videoID = item['id'];
    String title = item['snippet']['title'];
    String thumb = item['snippet']['thumbnails']['default']['url'];
    MinimalVideoItem minimalVideoItem = MinimalVideoItem(
        desc: desc, id: videoID, thumbnail: thumb, title: title);

    return minimalVideoItem;
  }
}
