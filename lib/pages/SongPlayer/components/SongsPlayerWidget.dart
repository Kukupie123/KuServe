// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors, duplicate_ignore

import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:utube_playlist_combiner/pages/HomePage/Components/Header/HeaderWidget.dart';
import 'package:utube_playlist_combiner/pages/SongPlayer/provider/providerSongsPlayer.dart';
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

  final YoutubePlayerController _ytc = YoutubePlayerController(
      initialVideoId: "dQw4w9WgXcQ",
      params: YoutubePlayerParams(
          autoPlay: true, enableCaption: false, color: 'red'));

  @override
  void initState() {
    super.initState();
    _ytc.setSize(Size(200, 200));
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
    var provider = Provider.of<ProviderSongsPlayer>(context, listen: false);
    if (widget.parentsSetting.arguments != null)
      provider.updateSongs(widget.parentsSetting.arguments as List<String>);
    _ytc.play();

    return Scaffold(
      body: YoutubeValueBuilder(
        controller: _ytc,
        builder: (BuildContext context, value) {
          if (value.isReady && !value.hasPlayed) {
            _ytc.play();
            if (kDebugMode) {
              print("Video is playing");
            }
          }
          return SizedBox(
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
                        children: [
                          SizedBox(
                            width: 150,
                            height: 150,
                            child: YoutubePlayerIFrame(
                              controller: _ytc,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
