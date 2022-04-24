// ignore_for_file: file_names, prefer_const_constructors, sized_box_for_whitespace, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../local_provider/providerHomepage.dart';

class PlaylistFieldWidget extends StatelessWidget {
  PlaylistFieldWidget({Key? key, required this.url, required this.index})
      : super(key: key);

  final int index;
  final String url;
  final TextEditingController tec = TextEditingController();

  @override
  Widget build(BuildContext context) {
    tec.text = url;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
          color: Colors.teal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                // height: MediaQuery.of(context).size.height * 0.2,
                child: TextFormField(
                  controller: tec,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Playlist URL',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0x00000000),
                        width: 1,
                      ),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(4.0),
                        topRight: Radius.circular(4.0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
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
                  keyboardType: TextInputType.url,
                  onChanged: (s) {
                    if (s.isNotEmpty) {
                      /*
                      1. Find position in queue of provider
                      2. If another widget exists after this then no need to do anything 
                      3. If no widget exists after this then add a new widget to the queue
                      */
                      var list =
                          Provider.of<ProviderHomePage>(context, listen: false)
                              .playlist;

                      int thisIndex = -1;
                      for (int i = 0; i < list.length; i++) {
                        if (list.elementAt(i) == this) {
                          thisIndex = i;

                          break;
                        } else {}
                      }

                      //check if thisIndex is last element
                      if (thisIndex == list.length - 1) {
                        //Last index so we need to add new item
                        Provider.of<ProviderHomePage>(context, listen: false)
                            .addNew();
                      } else {
                        //Not last so we do not need to do anything
                      }
                    } else if (index != 0) {
                      var list =
                          Provider.of<ProviderHomePage>(context, listen: false)
                              .playlist;
                      list.remove(this);
                      /*
                      1. 
                       */
                    }
                  },
                ),
              ),
              IconButton(
                  onPressed: () {
                    if (index != 0) {
                      Provider.of<ProviderHomePage>(context, listen: false)
                          .remove(this);
                    }
                  },
                  icon: Icon(Icons.delete))
            ],
          ),
        ),
      ),
    );
  }
}
