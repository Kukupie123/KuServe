// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utube_playlist_combiner/pages/HomePage/PageHome.dart';
import 'package:utube_playlist_combiner/pages/HomePage/local_provider/ProviderHome.dart';

import 'Routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProviderHome(),
        )
      ],
      builder: (c, i) => MaterialApp(
        title: "KUKODE UTube Playlist Combiner",
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),
        home: const PageHome(),
        onGenerateRoute: Routes.generateRoute,
        initialRoute: Routes.home,
      ),
    );
  }
}
