// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:utube_playlist_combiner/pages/combined/PageCombined.dart';
import 'package:utube_playlist_combiner/pages/landing/PageLanding.dart';

class Routes {
  static const String playListCombine = "/Playlist-combiner";
  static const String combined = "/combined";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case playListCombine:
        return _GeneratePageRoute(
            routeName: settings.name!, widget: PageLanding());
      case combined:
        return _GeneratePageRoute(
            routeName: settings.name!, widget: PageCombined(songs: []));
    }
    throw Exception("No route found");
  }
}

class _GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String routeName;
  _GeneratePageRoute({required this.widget, required this.routeName})
      : super(
            settings: RouteSettings(name: routeName),
            pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return widget;
            },
            transitionDuration: Duration(milliseconds: 500),
            transitionsBuilder: (BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child) {
              return SlideTransition(
                textDirection: TextDirection.rtl,
                position: Tween<Offset>(
                  begin: Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              );
            });
}
