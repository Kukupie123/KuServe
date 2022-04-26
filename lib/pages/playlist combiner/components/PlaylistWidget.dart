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

import '../local_provider/providerplaylistpage.dart';

class PlaylistWidget extends StatefulWidget {
  @override
  _PlaylistWidgetState createState() => _PlaylistWidgetState();
}

class _PlaylistWidgetState extends State<PlaylistWidget> {
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
                imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Image.asset(
                  "6.jpg",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HeaderIntroWebWidget(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100),
                    child: Consumer<ProviderPlaylist>(
                        builder: (context, value, child) => ListView(
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              children: Provider.of<ProviderPlaylist>(context,
                                      listen: false)
                                  .playlistInputFields
                                  .toList(),
                            )),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 18, left: 10, right: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AnimatedButton(
                      width: 150,
                      text: _buttonText,
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
              ),
            )
          ],
        ),
      )),
    );
  }

  bool _working = false;
  String _buttonText = "SUBMIT";
  @override
  Widget build(BuildContext context) {
    return _builder();
  }

  void _getSongs() async {
    if (_working) {
      return;
    }
    _working = true;
    setState(() {
      _buttonText = "PROCESSING";
    });
    try {
      var a = await Provider.of<ProviderPlaylist>(context, listen: false)
          .processPlaylist();

      Navigator.pushNamed(context, Routes.playlistCombined, arguments: a);
      _working = false;
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
      _working = false;
      setState(() {
        _buttonText = "SUBMIT";
      });
    }
    _working = false;
    setState(() {
      _buttonText = "SUBMIT";
    });
  }

  void _combinePlaylits() async {}
}
