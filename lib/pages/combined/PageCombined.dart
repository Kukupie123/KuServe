// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utube_playlist_combiner/pages/combined/components/PageCombined.dart';
import 'package:utube_playlist_combiner/pages/combined/local_provider/providerCombined.dart';

class PageCombined extends StatelessWidget {
  final List<String> songs;
  const PageCombined({Key? key, required this.songs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context, child) => CombinedWidget(songsIDs: songs),
      create: (context) => ProviderCombined(),
    );
  }
}
