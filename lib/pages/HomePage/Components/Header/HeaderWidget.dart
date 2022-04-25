// ignore_for_file: prefer_const_constructors, avoid_print, file_names, import_of_legacy_library_into_null_safe, prefer_const_literals_to_create_immutables, deprecated_member_use, avoid_unnecessary_containers

import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utube_playlist_combiner/Routes.dart';

class HeaderIntroWebWidget extends StatefulWidget {
  const HeaderIntroWebWidget({Key? key}) : super(key: key);

  @override
  _HeaderIntroWebWidgetState createState() => _HeaderIntroWebWidgetState();
}

class _HeaderIntroWebWidgetState extends State<HeaderIntroWebWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool mobile = false;
    log(size.height.toString());
    if (size.height <= 284) {
      //Too less height we need to show size is messed up
      return Container(
        child: Text(
            "Height is too small, switch device or resize to view header properly"),
      );
    }

    if (size.aspectRatio <= 1.0581222056631894 || size.width <= 710) {
      mobile = true;
      log("Header needs changing");
    }

    if (mobile) return _mobileHeader();
    return Hero(tag: "null", child: _desktopHeader());
  }

  Widget _mobileHeader() {
    return Container(
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xBECCDAE6), Color(0x896D7684), Colors.black],
          stops: [0, 1, 1],
          begin: AlignmentDirectional(0, -1),
          end: AlignmentDirectional(0, 1),
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              if (ModalRoute.of(context)!.settings.name != Routes.home) {
                log("Going homepage");
                Navigator.pushReplacementNamed(context, Routes.home);
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Text('Ku',
                    style: GoogleFonts.montserrat(
                        color: Color(0xFFC04064),
                        fontWeight: FontWeight.w900,
                        fontSize: 35)),
                Text(
                  'Serv',
                  style: GoogleFonts.montserrat(
                      color: Color(0xFF9FA8DA), fontSize: 35),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Color.fromARGB(0, 141, 169, 201),
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(10, 20),
                          topLeft: Radius.elliptical(10, 20),
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Contact me",
                              style: GoogleFonts.actor(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(10, 20),
                          topLeft: Radius.elliptical(10, 20),
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "About me",
                              style: GoogleFonts.actor(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(10, 20),
                          topLeft: Radius.elliptical(10, 20),
                          topRight: Radius.elliptical(10, 20),
                          bottomRight: Radius.elliptical(10, 20),
                        ),
                        child: Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Other Projects",
                              style: GoogleFonts.actor(
                                  color: Colors.black, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0x00EEEEEE),
                        ),
                        child: SingleChildScrollView(
                          child: AutoSizeText(
                            'Welcome,\nFellow Tarnished',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.oswald(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.instagramSquare,
                      color: Colors.black,
                      size: 20,
                    ),
                    onPressed: () {
                      print('Github pressed ...');
                    },
                  ),
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.github,
                      color: Colors.black,
                      size: 20,
                    ),
                    onPressed: () {
                      print('Github pressed ...');
                    },
                  ),
                  IconButton(
                    icon: FaIcon(
                      FontAwesomeIcons.linkedin,
                      color: Colors.black,
                      size: 20,
                    ),
                    onPressed: () {
                      print('Linkedin pressed ...');
                    },
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _desktopHeader() {
    return Container(
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xBECCDAE6), Color(0x896D7684), Colors.black],
          stops: [0, 1, 1],
          begin: AlignmentDirectional(0, -1),
          end: AlignmentDirectional(0, 1),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (ModalRoute.of(context)!.settings.name != Routes.home) {
                      log("Going homepage");
                      Navigator.pushReplacementNamed(context, Routes.home);
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text('Ku',
                          style: GoogleFonts.montserrat(
                              color: Color(0xFFC04064),
                              fontWeight: FontWeight.w900,
                              fontSize: 50)),
                      Text(
                        'Serv',
                        style: GoogleFonts.montserrat(
                            color: Color(0xFF9FA8DA), fontSize: 45),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.elliptical(10, 20),
                            topLeft: Radius.elliptical(10, 20),
                          ),
                          child: Container(
                            color: Color.fromARGB(50, 125, 154, 197),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Contact me",
                                style: GoogleFonts.actor(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.elliptical(10, 20),
                            topLeft: Radius.elliptical(10, 20),
                          ),
                          child: Container(
                            color: Color.fromARGB(50, 125, 154, 197),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "About me",
                                style: GoogleFonts.actor(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.elliptical(10, 20),
                            topLeft: Radius.elliptical(10, 20),
                            topRight: Radius.elliptical(10, 20),
                            bottomRight: Radius.elliptical(10, 20),
                          ),
                          child: Container(
                            color: Color.fromARGB(50, 125, 154, 197),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Other Projects",
                                style: GoogleFonts.actor(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.instagram,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () {
                        print('Instagram pressed ...');
                      },
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.github,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () {
                        print('Github pressed ...');
                      },
                    ),
                    IconButton(
                      icon: FaIcon(
                        FontAwesomeIcons.linkedin,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () {
                        print('Linkedin pressed ...');
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Color(0x00EEEEEE),
                    ),
                    child: SingleChildScrollView(
                      child: AutoSizeText(
                        'Welcome,\nFellow Tarnished',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.oswald(
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                            fontSize: 25),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
