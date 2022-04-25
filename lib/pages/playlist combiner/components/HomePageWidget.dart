// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, unnecessary_string_escapes, use_key_in_widget_constructors, file_names, import_of_legacy_library_into_null_safe, deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:utube_playlist_combiner/Routes.dart';
import 'package:utube_playlist_combiner/pages/HomePage/Components/Header/HeaderWidget.dart';

import '../local_provider/providerHomepage.dart';

class HomePageWidget extends StatefulWidget {
  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  Widget _builder() {
    return Scaffold(
      bottomNavigationBar: TitledBottomNavigationBar(
          onTap: (index) {
            //Here we can process based on index

            switch (index) {
              case 0:
                _getSongs();
                break;
              default:
            }
            print("Selected Index: $index");
          },
          items: [
            TitledNavigationBarItem(
              title: Text('Get Songs'),
              icon: Icon(FontAwesomeIcons.music),
            ),
            TitledNavigationBarItem(
              title: Text('Combine Playlist'),
              icon: Icon(FontAwesomeIcons.heartMusicCameraBolt),
            ),
          ]),
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
              children: [
                HeaderIntroWebWidget(),
                Expanded(
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
        widget: Flexible(
            child: Container(
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
                ))),
      );
    }
  }
}
