// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace

import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:utube_playlist_combiner/models/MinimalVideo.dart';
import 'package:utube_playlist_combiner/pages/SongPlayer/v2/songcard.dart';

class DetailAudioPage extends StatefulWidget {
  final RouteSettings parentsSetting;

  const DetailAudioPage({Key? key, required this.parentsSetting})
      : super(key: key);

  @override
  State<DetailAudioPage> createState() => _DetailAudioPageState();
}

class _DetailAudioPageState extends State<DetailAudioPage> {
  List<MinimalVideoItem?> _songs = [];
  int index = 0;
  final ap = AudioPlayer();
  final String baseURL = "https://fierce-reef-25402.herokuapp.com/";
  bool canPlay = false;

  @override
  void dispose() async {
    await ap.stop();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.parentsSetting.arguments != null) {
      _songs = widget.parentsSetting.arguments as List<MinimalVideoItem?>;
    }
    _loadSong();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return StreamBuilder<ProcessingState>(
        stream: ap.processingStateStream,
        builder: (context, state) {
          switch (state.data) {
            case ProcessingState.completed:
              _next();
              break;
            case ProcessingState.ready:
              canPlay = true;
              break;
            default:
              canPlay = false;
              break;
          }
          return Scaffold(
            backgroundColor: Color(0xFfdee7fa),
            body: Stack(
              children: [
                //BAR
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  height: height / 5,
                  child: Container(
                    color: Color.fromARGB(255, 158, 164, 238),
                  ),
                ),
                //Appbar
                Positioned(
                  top: 0,
                  right: 0,
                  left: 0,
                  child: AppBar(
                    elevation: 0,
                    backgroundColor: Color.fromARGB(255, 158, 164, 238),
                    leading: IconButton(
                      onPressed: () {},
                      icon: FaIcon(FontAwesomeIcons.backward),
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: FaIcon(FontAwesomeIcons.search),
                      ),
                    ],
                  ),
                ),
                //Player Desc
                Positioned(
                  top: height * 0.2,
                  left: 0,
                  right: 0,
                  height: height * 0.36,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.1,
                        ),
                        Text(
                          canPlay ? _songs[index]!.title : "Loading",
                          style: GoogleFonts.mallanna(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SingleChildScrollView(
                          child: AutoSizeText(
                            canPlay ? _songs[index]!.desc : "Loading",
                            style: GoogleFonts.mallanna(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                onPressed: canPlay ? _prev : null,
                                icon: FaIcon(
                                  FontAwesomeIcons.leftLong,
                                  size: 30,
                                ),
                              ),
                              _playButtonDecider(),
                              IconButton(
                                onPressed: canPlay ? _next : null,
                                icon: FaIcon(
                                  FontAwesomeIcons.rightLong,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                //Player thumbnail
                Positioned(
                  height: height * 0.16,
                  top: height * 0.12,
                  left: (width - 150) / 2,
                  right: (width - 150) / 2,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 230, 201, 231),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                          //borderRadius: BorderRadius.circular(20),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white,
                            width: 5,
                          ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: _mainThumbDecider(
                                canPlay, _songs[index]!.thumbnail),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //Playlist
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SongCardWidget(
                            thumb:
                                "https://images.unsplash.com/photo-1650928800498-034549200857?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
                            title: "Last song"),
                        Icon(FontAwesomeIcons.arrowRightArrowLeft),
                        SongCardWidget(
                            thumb:
                                "https://images.unsplash.com/photo-1650928800498-034549200857?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80",
                            title: "Last song"),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }

  ImageProvider _mainThumbDecider(bool canPlay, String url) {
    if (canPlay) return NetworkImage(url);
    return AssetImage("8.gif");
  }

  dynamic _play() async {
    if (ap.playerState.playing) {
      await ap.pause();
      return;
    }
    await ap.play();
  }

  dynamic _next() async {
    await ap.stop();
    if (index >= _songs.length - 1) return;
    setState(() {
      index++;
    });
    await _loadSong();
  }

  dynamic _prev() async {
    await ap.stop();
    if (index <= 0) return;

    setState(() {
      index--;
    });
    await _loadSong();
  }

  dynamic _loadSong() async {
    if (_songs.isEmpty) {
      await ap.setUrl(baseURL + "CF3Q7YfvH7Q");
      ap.load();
      // stream = ap.processingStateStream;
      return;
    }

    if (_songs[index] != null) {
      String url = baseURL + _songs[index]!.id.toString();
      await ap.setUrl(url);
      ap.load();
      //stream = ap.processingStateStream;
    } else {
      ap.setUrl(baseURL + "CF3Q7YfvH7Q");
      ap.load();
      // stream = ap.processingStateStream;
    }
  }

  Widget _playButtonDecider() {
    if (ap.playerState.playing) {
      return IconButton(
        onPressed: canPlay ? _play : null,
        icon: FaIcon(
          FontAwesomeIcons.pause,
          size: 30,
        ),
      );
    } else {
      return IconButton(
        onPressed: canPlay ? _play : null,
        icon: FaIcon(
          FontAwesomeIcons.play,
          size: 30,
        ),
      );
    }
  }
}
