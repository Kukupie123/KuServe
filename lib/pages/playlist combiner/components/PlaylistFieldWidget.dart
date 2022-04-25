// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace, avoid_print, import_of_legacy_library_into_null_safe

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:provider/provider.dart';

import '../local_provider/providerHomepage.dart';

class PlaylistFieldWidget extends StatelessWidget {
  PlaylistFieldWidget({Key? key, required this.index}) : super(key: key);

  final int index;
  final TextEditingController tec = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 20),
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: Color(0x56772F4D),
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: TextFormField(
                onChanged: (value) => _onInput(value, context),
                controller: tec,
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
    if (index != 0) {
      Provider.of<ProviderPlaylistCombiner>(context, listen: false)
          .remove(this);
    } else {
      SmartDialog.showToast("Can't delete initial field");
    }
  }

  void _onInput(String s, BuildContext context) {
    if (s.isNotEmpty) {
      var list = Provider.of<ProviderPlaylistCombiner>(context, listen: false)
          .playlist;

      int thisIndex = -1;
      for (int i = 0; i < list.length; i++) {
        if (list.elementAt(i) == this) {
          thisIndex = i;

          break;
        }
      }

      //check if thisIndex is last element
      if (thisIndex == list.length - 1) {
        //Last index so we need to add new item
        Provider.of<ProviderPlaylistCombiner>(context, listen: false).addNew();
        log("Adding new playlist");
      } else {
        //Not last so we do not need to do anything
        log("No need to add new playlist item");
      }
    } else if (index != 0) {
      var list = Provider.of<ProviderPlaylistCombiner>(context, listen: false)
          .playlist;
      list.remove(this);
    }
  }
}
