// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:flutter/material.dart';

class SongWidget extends StatelessWidget {
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
  Widget build(BuildContext context) {
    List colors = [
      Colors.pinkAccent,
      Colors.blueGrey,
      Colors.blueAccent,
      Colors.grey
    ];
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(100)),
      child: Card(
        child: Container(
          height: 200,
          width: 500,
          color: colors[Random().nextInt(colors.length - 1)],
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(thumb),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(title, style: TextStyle(fontSize: 3)),
                    Text(
                      desc,
                      style: TextStyle(fontSize: 3),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
