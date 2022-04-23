// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, unnecessary_string_escapes, use_key_in_widget_constructors, file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_playlist_combiner/pages/landing/local_provider/homepage_provider.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color(0xFF3F5777),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 0, 10, 0),
                child: Container(
                  width: 70,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFF9FA8DA),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: Text(
                      'Steps :\n1. Copy the URL of the playlist\n2. Paste it in the field below',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                  child: Consumer<ProviderHomePage>(
                    builder: (context, value, child) => Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.99,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFBCC8DA),
                            Color(0xFF51A9D3),
                            Color(0xFF2E4AD9)
                          ],
                          stops: [0, 1, 1],
                          begin: AlignmentDirectional(0, -1),
                          end: AlignmentDirectional(0, 1),
                        ),
                        borderRadius: BorderRadius.circular(25),
                        shape: BoxShape.rectangle,
                        border: Border.all(
                          color: Color(0xFF405979),
                          width: 5,
                        ),
                      ),
                      child: Consumer<ProviderHomePage>(
                        builder: (context, value, child) =>
                            SingleChildScrollView(
                          child: Column(
                              mainAxisSize: MainAxisSize.max,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: Provider.of<ProviderHomePage>(context,
                                      listen: false)
                                  .playlist
                                  .toList()),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(100, 10, 100, 0),
                child: IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.navigate_next_rounded,
                      color: Colors.black,
                      size: 50,
                    )),
                // child: FlutterFlowIconButton(
                //   borderColor: Colors.transparent,
                //   borderRadius: 30,
                //   borderWidth: 1,
                //   buttonSize: 60,
                //   icon: Icon(
                //     Icons.navigate_next_rounded,
                //     color: Colors.black,
                //     size: 50,
                //   ),
                //   onPressed: () {
                //     print('IconButton pressed ...');
                //   },
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
