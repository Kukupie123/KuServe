// ignore_for_file: file_names, import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/PlaylistWidget.dart';
import 'local_provider/providerplaylistpage.dart';

class PagePlaylist extends StatefulWidget {
  const PagePlaylist({Key? key}) : super(key: key);

  @override
  State<PagePlaylist> createState() => _PagePlaylistState();
}

class _PagePlaylistState extends State<PagePlaylist> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderPlaylist(),
      child: PlaylistWidget(),
    );
  }
}
