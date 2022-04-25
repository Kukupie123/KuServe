// ignore_for_file: file_names, prefer_const_constructors, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utube_playlist_combiner/pages/listSongs/components/ListSongWidget.dart';
import 'package:utube_playlist_combiner/pages/listSongs/local_provider/providerListSong.dart';

class PageListSong extends StatelessWidget {
  const PageListSong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var a = ModalRoute.of(context)!.settings;
    return ChangeNotifierProvider(
      builder: (context, child) => ListSongWidget(parentSetting: a),
      create: (context) => ProviderListSong(),
    );
  }
}
