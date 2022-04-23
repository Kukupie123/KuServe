import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_playlist_combiner/pages/landing/PageLanding.dart';
import 'package:youtube_playlist_combiner/pages/landing/local_provider/providerHomepage.dart';

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
        ChangeNotifierProvider(create: (context) => ProviderHomePage())
      ],
      child: MaterialApp(
          title: "KUKODE UTube Playlist Combiner",
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
          ),
          home: const PageLanding()),
    );
  }
}
