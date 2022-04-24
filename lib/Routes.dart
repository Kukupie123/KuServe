// ignore_for_file: prefer_const_constructors, file_names, prefer_const_literals_to_create_immutables

import 'package:flutter/cupertino.dart';
import 'package:utube_playlist_combiner/pages/HomePage/PageHome.dart';
import 'package:utube_playlist_combiner/pages/combined/PageCombined.dart';
import 'package:utube_playlist_combiner/pages/playlist%20combiner/PageLanding.dart';

class Routes {
  static const String playListCombine = "/Playlist-combiner";
  static const String playlistCombined = "/combined";
  static const String home = "/";

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case playListCombine:
        return _GeneratePageRoute(settings.arguments,
            routeName: settings.name!, widget: PagePlaylistCombiner());

      case playlistCombined:
        return _GeneratePageRoute(settings.arguments,
            routeName: settings.name!, widget: PagePlaylistCombined());

      case home:
        return _GeneratePageRoute(settings.arguments,
            widget: PageHome(), routeName: settings.name!);
    }
    throw Exception("No route found");
  }
}

class _GeneratePageRoute extends PageRouteBuilder {
  final Widget widget;
  final String routeName;
  final Object? arg;
  _GeneratePageRoute(this.arg, {required this.widget, required this.routeName})
      : super(
            settings: RouteSettings(name: routeName, arguments: arg),
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
