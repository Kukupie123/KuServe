// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace, avoid_print, import_of_legacy_library_into_null_safe, must_be_immutable

import 'dart:developer';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

import '../local_provider/providerplaylistpage.dart';

class PlaylistFieldWidget extends StatefulWidget {
  String? url;
  PlaylistFieldWidget({Key? key, required this.index, this.url})
      : super(key: key) {
    tec = TextEditingController(text: url ?? "");
  }
  final int index;
  late final TextEditingController tec;

  @override
  State<PlaylistFieldWidget> createState() => _PlaylistFieldWidgetState();
}

class _PlaylistFieldWidgetState extends State<PlaylistFieldWidget> {
  final rand = Random();

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

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 700), () {
      setState(() {});
    });
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 350),
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
          gradient: LinearGradient(
            colors: [
              colors[rand.nextInt(colors.length - 1)],
              colors[rand.nextInt(colors.length - 1)],
              colors[rand.nextInt(colors.length - 1)],
              colors[rand.nextInt(colors.length - 1)],
            ],
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: TextFormField(
                onChanged: (value) => _onInput(value, context),
                controller: widget.tec,
                obscureText: false,
                decoration: InputDecoration(
                  hintText: 'Playlist Link here',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4.0),
                      topRight: Radius.circular(4.0),
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
                icon: Icon(
                  Icons.delete_outlined,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () => _onDelete(context)),
          ],
        ),
      ),
    );
  }

  void _onDelete(BuildContext context) {
    if (widget.index != 0) {
      Provider.of<ProviderPlaylist>(context, listen: false).remove(widget);
    } else {
      SmartDialog.showToast("Can't delete initial field");
    }
  }

  void _onInput(String s, BuildContext context) {
    if (s.isNotEmpty) {
      var list = Provider.of<ProviderPlaylist>(context, listen: false).playlist;

      int thisIndex = -1;
      for (int i = 0; i < list.length; i++) {
        if (list.elementAt(i) == widget) {
          thisIndex = i;

          break;
        }
      }

      //check if thisIndex is last element
      if (thisIndex == list.length - 1) {
        //Last index so we need to add new item
        Provider.of<ProviderPlaylist>(context, listen: false).addNew();
      } else {
        //Not last so we do not need to do anything
      }
    } else if (widget.index != 0) {
      var list = Provider.of<ProviderPlaylist>(context, listen: false).playlist;
      list.remove(this);
    }
  }
}
