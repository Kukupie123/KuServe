// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors, duplicate_ignore, file_names

import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class SongsPlayerWidget extends StatefulWidget {
  final RouteSettings parentsSetting;
  const SongsPlayerWidget({Key? key, required this.parentsSetting})
      : super(key: key);

  @override
  State<SongsPlayerWidget> createState() => _SongsPlayerWidgetState();
}

class _SongsPlayerWidgetState extends State<SongsPlayerWidget> {
  final rand = Random(123);
  final List colors = [
    Color.fromARGB(127, 255, 64, 128),
    Color.fromARGB(125, 96, 125, 139),
    Color.fromARGB(125, 68, 137, 255),
    Color.fromARGB(124, 28, 70, 143),
    Color.fromARGB(122, 158, 158, 158),
    Color.fromARGB(104, 71, 92, 56),
    Color.fromARGB(155, 13, 177, 218),
    Color.fromARGB(121, 185, 41, 41),
    Color.fromARGB(121, 9, 30, 54),
    Color.fromARGB(121, 30, 170, 163),
    Color.fromARGB(121, 156, 155, 95),
  ];

  late YoutubePlayerController _yts;
  List<String?> _songs = [];

  @override
  void initState() {
    super.initState();
    _songs = widget.parentsSetting.arguments as List<String?>;

    _yts = YoutubePlayerController(
      initialVideoId: _songs[0]!,
      params: YoutubePlayerParams(
        playlist: _getAllSongsExceptFirst(), // Defining custom playlist
        showControls: true,
        showFullscreenButton: false,
        color: 'black',
      ),
    );

    _yts.setSize(Size(5000, 5000));
  }

  List<String> _getAllSongsExceptFirst() {
    List<String> l = [];

    var iterator = _songs.iterator;

    while (iterator.moveNext()) {
      if (iterator.current == _songs[0]) continue;
      l.add(iterator.current!);
    }
    return l;
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(milliseconds: 2000),
      () {
        setState(() {});
      },
    );

    //Update the variable of provider. This is going to be used to show list of songs to user

    return Scaffold(
        body: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          //Background Image
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: CachedNetworkImage(
              imageUrl:
                  "https://img3.goodfon.com/wallpaper/nbig/4/12/3d-fioletovyy-krugi-svechenie.jpg",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),

          //Sub container in middle
          // ignore: prefer_const_constructors
          Align(
            alignment: AlignmentDirectional.center,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 10, sigmaY: 8, tileMode: TileMode.clamp),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 1500),
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.85,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(20, 20),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      colors[rand.nextInt(colors.length - 1)],
                      colors[rand.nextInt(colors.length - 1)],
                      colors[rand.nextInt(colors.length - 1)],
                      colors[rand.nextInt(colors.length - 1)],
                    ],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 650,
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: YoutubePlayerIFrame(
                        controller: _yts,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
