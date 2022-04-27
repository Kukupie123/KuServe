// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utube_playlist_combiner/pages/SongPlayer/v2/detailaudiopage.dart';
import 'package:utube_playlist_combiner/pages/SongPlayer/v2/provider/providersongplayer.dart';

class PageSongPlayerWrapper extends StatelessWidget {
  const PageSongPlayerWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var a = ModalRoute.of(context)!.settings;
    return ChangeNotifierProvider(
      builder: (context, child) => DetailAudioPage(parentsSetting: a),
      create: (context) => ProviderSongPlayer(),
    );
  }
}
