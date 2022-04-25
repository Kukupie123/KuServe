// ignore_for_file: prefer_const_literals_to_create_immutables, import_of_legacy_library_into_null_safe

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';
import 'package:utube_playlist_combiner/pages/HomePage/PageHome.dart';
import 'package:utube_playlist_combiner/pages/HomePage/local_provider/ProviderHome.dart';

import 'Routes.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails e) {
    if (kDebugMode) {
      print(e.exception.toString());
    }
  };
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
        navigatorObservers: [FlutterSmartDialog.observer],
        builder: FlutterSmartDialog.init(),
        title: "KUKUKODE's KuServ",
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
