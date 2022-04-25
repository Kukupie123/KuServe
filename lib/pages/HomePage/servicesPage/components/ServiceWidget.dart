// ignore_for_file: unused_import, prefer_const_constructors, file_names

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ServicecardWebWidget extends StatefulWidget {
  final String title;
  final String desc;
  final String imageURL;
  const ServicecardWebWidget(
      {Key? key,
      required this.title,
      required this.desc,
      required this.imageURL})
      : super(key: key);

  @override
  _ServicecardWebWidgetState createState() => _ServicecardWebWidgetState();
}

class _ServicecardWebWidgetState extends State<ServicecardWebWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0x5F975959),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 20, 0),
            child: Image.network(
              widget.imageURL,
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.height * 0.2,
              fit: BoxFit.cover,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  widget.title,
                  maxLines: 1,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.montserrat(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                AutoSizeText(
                  widget.desc,
                  maxLines: 3,
                  textAlign: TextAlign.start,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
