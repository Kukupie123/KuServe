import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SongCardWidget extends StatefulWidget {
  final String thumb;
  final String title;
  const SongCardWidget({Key? key, required this.thumb, required this.title})
      : super(key: key);

  @override
  State<SongCardWidget> createState() => _SongCardWidgetState();
}

class _SongCardWidgetState extends State<SongCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.3,
          width: MediaQuery.of(context).size.height * 0.3,
          child: Stack(
            children: [
              Image.network(
                widget.thumb,
                fit: BoxFit.cover,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  widget.title,
                  style: GoogleFonts.zenAntique(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
