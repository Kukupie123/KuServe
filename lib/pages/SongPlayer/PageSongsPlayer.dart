// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utube_playlist_combiner/pages/SongPlayer/components/SongsPlayerWidget.dart';
import 'package:utube_playlist_combiner/pages/SongPlayer/provider/providerSongsPlayer.dart';

class PageSongsPlayer extends StatelessWidget {
  const PageSongsPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context, child) =>
          SongsPlayerWidget(parentsSetting: ModalRoute.of(context)!.settings),
      create: (context) => ProviderSongsPlayer(),
    );
  }
}
