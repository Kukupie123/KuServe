// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_playlist_combiner/pages/landing/components/HomePageWidget.dart';

class PageLanding extends StatefulWidget {
  const PageLanding({Key? key}) : super(key: key);

  @override
  State<PageLanding> createState() => _PageLandingState();
}

class _PageLandingState extends State<PageLanding> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, value, child) => HomePageWidget(),
    );
  }
}
