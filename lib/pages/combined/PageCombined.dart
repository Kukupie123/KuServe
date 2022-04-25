// ignore_for_file: file_names, prefer_const_constructors, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utube_playlist_combiner/pages/combined/components/PageCombined.dart';
import 'package:utube_playlist_combiner/pages/combined/local_provider/providerCombined.dart';

class PagePlaylistCombined extends StatelessWidget {
  const PagePlaylistCombined({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var a = ModalRoute.of(context)!.settings;
    return ChangeNotifierProvider(
      builder: (context, child) => CombinedWidget(parentSetting: a),
      create: (context) => ProviderCombined(),
    );
  }
}
