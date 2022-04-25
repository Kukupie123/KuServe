// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class SongWidget extends StatefulWidget {
  final String title;
  final String id;
  final String desc;
  final String thumb;
  const SongWidget(
      {Key? key,
      required this.title,
      required this.id,
      required this.desc,
      required this.thumb})
      : super(key: key);

  @override
  State<SongWidget> createState() => _SongWidgetState();
}

class _SongWidgetState extends State<SongWidget> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {});
    });
    Size size = MediaQuery.of(context).size;
    if (size.height <= 284) {}

    if (size.aspectRatio <= 1.0581222056631894 || size.width <= 710) {
      return _mobile();
    }
    return _desk();
  }

//TODO Make gradient shift smooth
  Widget _mobile() {
    List colors = [
      Color.fromARGB(127, 255, 64, 128),
      Color.fromARGB(125, 96, 125, 139),
      Color.fromARGB(125, 68, 137, 255),
      Color.fromARGB(122, 158, 158, 158)
    ];
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colors[Random().nextInt(colors.length - 1)],
                  colors[Random().nextInt(colors.length - 1)],
                  colors[Random().nextInt(colors.length - 1)],
                  colors[Random().nextInt(colors.length - 1)],
                ],
              ),
            ),
            height: 200,
            width: double.infinity,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 10, sigmaY: 8, tileMode: TileMode.clamp),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(widget.thumb),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                                overflow: TextOverflow.clip,
                                fontSize: 20,
                                fontWeight: FontWeight.w800),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            widget.desc,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 15,
                              overflow: TextOverflow.clip,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _desk() {
    List colors = [
      Color.fromARGB(127, 255, 64, 128),
      Color.fromARGB(125, 96, 125, 139),
      Color.fromARGB(125, 68, 137, 255),
      Color.fromARGB(122, 158, 158, 158)
    ];
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colors[Random().nextInt(colors.length - 1)],
                  colors[Random().nextInt(colors.length - 1)],
                  colors[Random().nextInt(colors.length - 1)],
                  colors[Random().nextInt(colors.length - 1)],
                ],
              ),
            ),
            height: 200,
            width: double.infinity,
            child: BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 10, sigmaY: 8, tileMode: TileMode.clamp),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.network(widget.thumb),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                                overflow: TextOverflow.clip,
                                fontSize: 20,
                                fontWeight: FontWeight.w800),
                            textAlign: TextAlign.start,
                          ),
                          Text(
                            widget.desc,
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            style: TextStyle(
                              fontSize: 15,
                              overflow: TextOverflow.clip,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
