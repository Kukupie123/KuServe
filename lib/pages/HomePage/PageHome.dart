// ignore_for_file: file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, import_of_legacy_library_into_null_safe

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:provider/provider.dart';
import 'package:utube_playlist_combiner/pages/HomePage/Components/Header/HeaderWidget.dart';
import 'package:utube_playlist_combiner/pages/HomePage/local_provider/ProviderHome.dart';

class PageHome extends StatefulWidget {
  const PageHome({Key? key}) : super(key: key);

  @override
  State<PageHome> createState() => _PageHomeState();
}

class _PageHomeState extends State<PageHome> {
  @override
  Widget build(BuildContext context) {
    var homeProvider = Provider.of<ProviderHome>(context, listen: false);
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            ClipRRect(
              child: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 2, sigmaY: 20),
                child: Align(
                  alignment: AlignmentDirectional(0, 0),
                  child: Image.asset(
                    '1.gif',
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 1,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Consumer<ProviderHome>(
              builder: (context, value, child) => Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HeaderIntroWebWidget(),
                    Expanded(child: homeProvider.getView())
                  ]),
            )
          ],
        ),
      ),
      bottomNavigationBar: MotionTabBar(
        labels: [
          'Services',
          'Personal Blogs',
        ],
        initialSelectedTab: 'Services',
        tabSelectedColor: Color.fromARGB(255, 119, 153, 180),
        icons: [FontAwesomeIcons.servicestack, FontAwesomeIcons.blogger],
        onTabItemSelected: (i) => {homeProvider.updateIndex(i)},
        tabBarColor: Color.fromARGB(22, 97, 52, 82),
        tabIconSelectedColor: Color.fromARGB(162, 97, 52, 82),
      ),
    );
  }
}
