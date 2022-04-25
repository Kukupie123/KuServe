// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';
import 'package:utube_playlist_combiner/pages/SongPlayer/components/SongsPlayerWidget.dart';

class PageSongsPlayer extends StatelessWidget {
  const PageSongsPlayer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SongsPlayerWidget(parentsSetting: ModalRoute.of(context)!.settings);
  }
}
