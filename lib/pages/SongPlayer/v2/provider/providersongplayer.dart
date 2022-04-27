// ignore_for_file: prefer_final_fields, unused_field

import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../models/MinimalVideo.dart';

class ProviderSongPlayer with ChangeNotifier {
  final String _baseURL = "https://fierce-reef-25402.herokuapp.com/";

  var _ap = AudioPlayer();

  int _index = 0;

  List<MinimalVideoItem?> _songs = [];

  bool _playing = false;

  late ProcessingState _processingState;

  late ConcatenatingAudioSource _playlist;

  ///Sets the song and then notifies
  void initialize(List<MinimalVideoItem?> songs) async {
    _songs = songs; //initialize songs like
    _index = 0; //reset index

    //Set playlist for ap
    List<AudioSource> playlistSongs = [];
    for (var song in _songs) {
      final uri = Uri.parse(_baseURL + song!.id);
      playlistSongs.add(AudioSource.uri(uri, tag: song.id));
    }
    _playlist = ConcatenatingAudioSource(children: playlistSongs);
    await _ap.setAudioSource(_playlist);

    //listeners

    //Playing
    _ap.playingStream.listen((e) {
      _playing = e;
      notifyListeners();
    });

    _ap.playerStateStream.listen((event) {
      _processingState = event.processingState;
      notifyListeners();
    });

    _ap.load();
  }
}
