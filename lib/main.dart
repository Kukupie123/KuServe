// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:utube_playlist_combiner/Routes.dart';
import 'package:utube_playlist_combiner/pages/landing/PageLanding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "KUKODE UTube Playlist Combiner",
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const PageLanding(),
      onGenerateRoute: Routes.generateRoute,
      initialRoute: Routes.playListCombine,
    );
  }
}
