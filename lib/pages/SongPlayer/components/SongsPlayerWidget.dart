// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors, duplicate_ignore, file_names

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:just_audio/just_audio.dart';
import 'package:utube_playlist_combiner/models/MinimalVideo.dart';

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
    Color.fromARGB(136, 56, 100, 25),
    Color.fromARGB(155, 13, 177, 218),
    Color.fromARGB(121, 185, 41, 41),
    Color.fromARGB(121, 9, 30, 54),
    Color.fromARGB(190, 30, 170, 163),
    Color.fromARGB(121, 156, 155, 95),
  ];

  List<MinimalVideoItem?> _songs = [];

  final ap = AudioPlayer();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.parentsSetting.arguments != null) {
      _songs = widget.parentsSetting.arguments as List<MinimalVideoItem?>;

      ap.setAudioSource(
        ConcatenatingAudioSource(
          children: List.generate(_songs.length, (i) {
            return AudioSource.uri(Uri.parse(
                "https://fierce-reef-25402.herokuapp.com/" + _songs[i]!.id));
          }),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(
      Duration(milliseconds: 500),
      () {
        setState(() {});
      },
    );
    return Scaffold(
        body: SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          //Background Image
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
            child: Image.asset(
              "8.gif",
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
                    IconButton(
                      onPressed: () async {
                        await ap.stop();
                        await ap.play();
                      },
                      icon: Icon(FontAwesomeIcons.play),
                    ),
                    IconButton(
                      onPressed: () async {
                        await ap.seekToNext();
                        await ap.play();
                      },
                      icon: Icon(FontAwesomeIcons.synagogue),
                    ),
                    IconButton(
                      onPressed: () async {
                        await ap.stop();
                      },
                      icon: Icon(FontAwesomeIcons.stop),
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
