// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, unnecessary_string_escapes, use_key_in_widget_constructors, file_names, import_of_legacy_library_into_null_safe, deprecated_member_use, sized_box_for_whitespace, prefer_final_fields, unused_element, curly_braces_in_flow_control_structures

import 'dart:ui';

import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:utube_playlist_combiner/Routes.dart';
import 'package:utube_playlist_combiner/pages/HomePage/Components/Header/HeaderWidget.dart';

import '../local_provider/providerHomepage.dart';

class HomePageWidget extends StatefulWidget {
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool _play = true;

  @override
  void initState() {
    super.initState();
  }

  Widget _builder() {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: CircleNavBar(
        activeIcons: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Play Songs",
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSansKhudawadi(fontSize: 12),
              ),
              Icon(Icons.favorite, color: Color.fromARGB(255, 0, 0, 0)),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Combine Playlists",
                textAlign: TextAlign.center,
                style: GoogleFonts.notoSansKhudawadi(fontSize: 12),
              ),
              Icon(Icons.favorite, color: Color.fromARGB(255, 0, 0, 0)),
            ],
          ),
        ],
        inactiveIcons: const [
          Text("Play Songs"),
          Text("Combine Playlists into one"),
        ],
        color: Color.fromARGB(41, 231, 9, 164),
        height: 70,
        circleWidth: 70,
        initIndex: 0,
        onChanged: (v) {},
        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
          bottomRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
        shadowColor: Color.fromARGB(117, 0, 0, 0),
        elevation: 5,
      ),
      body: SafeArea(
          child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Stack(
          children: [
            ClipRect(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 12, sigmaY: 56),
                child: Image.network(
                  "https://picsum.photos/seed/152/600",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    HeaderIntroWebWidget(),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.3,
                      child: Consumer<ProviderPlaylistCombiner>(
                        builder: (context, value, child) => Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                                child: ListView(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              children: Provider.of<ProviderPlaylistCombiner>(
                                      context,
                                      listen: false)
                                  .playlist
                                  .toList(),
                            ))
                          ],
                        ),
                      ),
                    ),
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
                        text: 'SUBMIT',
                        isReverse: true,
                        selectedTextColor: Color.fromARGB(127, 0, 0, 0),
                        transitionType: TransitionType.LEFT_TO_RIGHT,
                        backgroundColor: Color.fromARGB(82, 0, 0, 0),
                        borderColor: Colors.white,
                        borderRadius: 50,
                        borderWidth: 2,
                        onPress: () {
                          if (_play)
                            _getSongs();
                          else
                            _combinePlaylits();
                        },
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _builder();
  }

  void _getSongs() async {
    try {
      var a =
          await Provider.of<ProviderPlaylistCombiner>(context, listen: false)
              .processPlaylist();

      Navigator.pushNamed(context, Routes.playlistCombined, arguments: a);
    } on Exception catch (e) {
      SmartDialog.showLoading(
        clickBgDismissTemp: true,
        backDismiss: true,
        widget: Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                e.toString().replaceAll("Exception:", ""),
                style: GoogleFonts.yrsa(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            )),
      );
    }
  }

  void _combinePlaylits() async {}
}
