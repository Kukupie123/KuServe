// ignore_for_file: file_names, non_constant_identifier_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, curly_braces_in_flow_control_structures, unused_local_variable, avoid_print, deprecated_member_use

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:utube_playlist_combiner/pages/HomePage/Components/Header/HeaderWidget.dart';
import 'package:utube_playlist_combiner/pages/combined/components/SongWidget.dart';
import 'package:utube_playlist_combiner/pages/combined/local_provider/providerCombined.dart';

class CombinedWidget extends StatefulWidget {
  final RouteSettings parentSetting;
  const CombinedWidget({Key? key, required this.parentSetting})
      : super(key: key);

  @override
  State<CombinedWidget> createState() => _CombinedWidgetState();
}

class _CombinedWidgetState extends State<CombinedWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var providerCombined =
        Provider.of<ProviderCombined>(context, listen: false);
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
            print("Selected Index: $index");
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
        child: Consumer<ProviderCombined>(
          builder: (context, value, child) => Stack(
            children: [
              ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
                child: CachedNetworkImage(
                  imageUrl:
                      "https://img3.goodfon.com/wallpaper/nbig/4/12/3d-fioletovyy-krugi-svechenie.jpg",
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
                      child: Expanded(child: _videsWidgetDecider()),
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
                      onPress: () {},
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
        Provider.of<ProviderCombined>(context, listen: false);

    if (Provider.of<ProviderCombined>(context, listen: false).itemVideos ==
        null) {
      return Text("Processing songs");
    } else {
      if (providerCombined.itemVideos!.isEmpty)
        return Text("Empty");
      else {
        //songs are there
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
}
