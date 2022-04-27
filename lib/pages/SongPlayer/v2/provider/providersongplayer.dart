// ignore_for_file: prefer_final_fields, unused_field

import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

import '../../../../models/MinimalVideo.dart';

class ProviderSongPlayer with ChangeNotifier {
  final String _baseURL = "https://uttube-kuserv-api.herokuapp.com/";

  var _ap = AudioPlayer();

  int _index = 0;

  List<MinimalVideoItem?> _songs = [];

  bool isPlaying = false;

  late ProcessingState processingState = ProcessingState.idle;

  late ConcatenatingAudioSource _playlist;

  MinimalVideoItem getCurrentSong() {
    return _songs[_index]!;
  }

  Future<void> play() async {
    if (isPlaying) {
      await _ap.pause();
      return;
    }
    await _ap.play();
  }

  Future<void> next() async {
    if (isPlaying) await _ap.stop();
    await _ap.seekToNext();
    await _ap.play();
  }

  Future<void> prev() async {
    if (isPlaying) await _ap.stop();

    await _ap.seekToPrevious();
    await _ap.play();
  }

  Future<void> loadSongs() async {
    _index = 0; //reset index
    //Set playlist for ap
    List<AudioSource> playlistSongs = [];
    for (var song in _songs) {
      final uri = Uri.parse(_baseURL + song!.id);
      playlistSongs.add(AudioSource.uri(uri, tag: song));
    }
    _playlist = ConcatenatingAudioSource(children: playlistSongs);
    await _ap.setAudioSource(_playlist);
  }

  ///Sets the song and then notifies
  void initialize(List<MinimalVideoItem?> songs) async {
    _ap.setCanUseNetworkResourcesForLiveStreamingWhilePaused(true);
    _songs = songs; //initialize songs like
    await loadSongs();

    //listeners

    //Playing
    _ap.playingStream.listen((e) {
      isPlaying = e;
      log("playing state triggered $isPlaying");
      notifyListeners();
    }, onError: (e) {
      log(e.toString());
    });

    _ap.playerStateStream.listen((event) async {
      processingState = event.processingState;
      log("processing state triggered $processingState");
      notifyListeners();
    }, onError: (e) {
      log(e.toString());
    });

    _ap.playbackEventStream.listen((event) async {
      if (event.currentIndex != _index) {
        _index = event.currentIndex!;
        log("Updated _index to $_index");
        notifyListeners();
      }
    });

    await _ap.play();
  }
}
