// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, curly_braces_in_flow_control_structures, unused_local_variable, avoid_print, deprecated_member_use

import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:utube_playlist_combiner/Routes.dart';
import 'package:utube_playlist_combiner/pages/HomePage/Components/Header/HeaderWidget.dart';
import 'package:utube_playlist_combiner/pages/listSongs/local_provider/providerListSong.dart';
import 'package:utube_playlist_combiner/services/Basicservice.dart';

import 'SongWidget.dart';

//TODO: Show songs that have been loaded
class ListSongWidget extends StatefulWidget {
  final RouteSettings parentSetting;
  const ListSongWidget({Key? key, required this.parentSetting})
      : super(key: key);

  @override
  State<ListSongWidget> createState() => _ListSongWidgetState();
}

class _ListSongWidgetState extends State<ListSongWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var providerCombined =
        Provider.of<ProviderListSong>(context, listen: false);
    if (widget.parentSetting.arguments != null)
      providerCombined.songsIDs =
          widget.parentSetting.arguments as List<String?>;

    providerCombined.getVideoItemsFromSongs();

    return Scaffold(
      bottomNavigationBar: TitledBottomNavigationBar(
          onTap: (index) {
            //Here we can process based on index
            switch (index) {
              case 0:
                break;
              default:
            }
          },
          items: [
            TitledNavigationBarItem(
              title: Text(''),
              icon: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Order",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSansKhudawadi(fontSize: 12),
                  ),
                  Icon(Icons.music_note, color: Color.fromARGB(255, 0, 0, 0)),
                ],
              ),
            ),
            TitledNavigationBarItem(
              title: Text(''),
              icon: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Shuffle",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.notoSansKhudawadi(fontSize: 12),
                  ),
                  Icon(Icons.shuffle, color: Color.fromARGB(255, 0, 0, 0)),
                ],
              ),
            ),
          ]),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Consumer<ProviderListSong>(
          builder: (context, value, child) => Stack(
            children: [
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: Image.asset(
                  "7.jpg",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Column(
                //TODO move button on stack and overlay with list
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  HeaderIntroWebWidget(),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: _videsWidgetDecider(),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AnimatedButton(
                      height: 70,
                      width: 150,
                      text: 'Play',
                      isReverse: true,
                      selectedTextColor: Color.fromARGB(127, 0, 0, 0),
                      transitionType: TransitionType.LEFT_TO_RIGHT,
                      backgroundColor: Color.fromARGB(82, 0, 0, 0),
                      borderColor: Colors.white,
                      borderRadius: 50,
                      borderWidth: 2,
                      onPress: () => _playPressed(),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _videsWidgetDecider() {
    var providerCombined =
        Provider.of<ProviderListSong>(context, listen: false);

    if (Provider.of<ProviderListSong>(context, listen: false).itemVideos ==
        null) {
      return Text(
        "Processing songs",
        style: GoogleFonts.goudyBookletter1911(fontSize: 59),
      );
    } else {
      if (providerCombined.itemVideos!.isEmpty)
        return ListView(
          children: List.generate(
            4,
            (index) {
              if (index == 0)
                return Text(
                  "No video Found. Please go back to playlist combine page",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.kadwa(
                      color: Color.fromARGB(255, 232, 235, 196),
                      fontWeight: FontWeight.w600,
                      fontSize: 25),
                );
              return SongWidget(
                desc: "",
                id: "",
                thumb: "",
                title: "",
              );
            },
          ),
        );
      else {
        //songs are there
        log(providerCombined.itemVideos!.length.toString());
        return ListView(
          children: List.generate(
            providerCombined.itemVideos!.length,
            (index) => SongWidget(
              desc: providerCombined.itemVideos![index].desc,
              id: providerCombined.itemVideos![index].id,
              thumb: providerCombined.itemVideos![index].thumbnail,
              title: providerCombined.itemVideos![index].title,
            ),
          ),
        );
      }
    }
  }

  void _playPressed() async {
    var pro = Provider.of<ProviderListSong>(context, listen: false);

    Navigator.pushReplacementNamed(context, Routes.songsPlayer,
        arguments: BasicService.shuffle(pro.songsIDs));
  }
}
