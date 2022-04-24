// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:utube_playlist_combiner/models/PlaylistItem.dart';

/*
 * curl \
  'https://youtube.googleapis.com/youtube/v3/playlistItems?part=contentDetails&playlistId=PLfJxOs8CS6Bsr6opEuSQcm_iAvAQvMexx&access_token=AIzaSyAEnBieHIcJcqNJld9EYw6Ov8nzVJGh7Fg&key=[YOUR_API_KEY]' \
  --header 'Accept: application/json' \
  --compressed
 */

class UtubeService {
  static const _baseUrl = "www.googleapis.com";
  static const _key = "AIzaSyAEnBieHIcJcqNJld9EYw6Ov8nzVJGh7Fg";

  static Future<PlaylistItem> getSongsFromPlaylist(String playlistID) async {
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
    PlaylistItem playlistItem = PlaylistItem.fromJson(json.decode(resp.body));
    return playlistItem;
  }
}
