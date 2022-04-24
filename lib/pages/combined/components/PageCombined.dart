// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, curly_braces_in_flow_control_structures, unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utube_playlist_combiner/pages/combined/components/SongWidget.dart';
import 'package:utube_playlist_combiner/pages/combined/local_provider/providerCombined.dart';

class CombinedWidget extends StatefulWidget {
  final RouteSettings parentSetting;
  const CombinedWidget({Key? key, required this.parentSetting})
      : super(key: key);

  @override
  State<CombinedWidget> createState() => _CombinedWidgetState();
}

class _CombinedWidgetState extends State<CombinedWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var providerCombined =
        Provider.of<ProviderCombined>(context, listen: false);

    providerCombined.songsIDs = widget.parentSetting.arguments as List<String?>;

    providerCombined.getVideoItemsFromSongs();

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Consumer<ProviderCombined>(
            child: _videsWidgetDecider(),
            builder: (context, value, child) =>
                SingleChildScrollView(child: _videsWidgetDecider())),
      ),
    );
  }

  Widget _videsWidgetDecider() {
    var providerCombined =
        Provider.of<ProviderCombined>(context, listen: false);

    if (Provider.of<ProviderCombined>(context, listen: false).itemVideos ==
        null) {
      return Text("Processing songs");
    } else {
      if (providerCombined.itemVideos!.isEmpty)
        return Text("Processing songs");
      else {
        //songs are there
        return Column(
            children: List.generate(
                providerCombined.itemVideos!.length,
                (index) => SongWidget(
                      desc: providerCombined.itemVideos![index].desc,
                      id: providerCombined.itemVideos![index].id,
                      thumb: providerCombined.itemVideos![index].thumbnail,
                      title: providerCombined.itemVideos![index].title,
                    )));
      }
    }
  }
}
