import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';

import 'package:expenseTracker/screens/home.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _currentIndex = 0;
  bool _isVisible;
  ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _isVisible = true;
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
        if (_isVisible) {
          setState(() {
            _isVisible = false;
          });
        }
      }
      if (_controller.position.userScrollDirection == ScrollDirection.forward) {
        if (!_isVisible)
          setState(() {
            _isVisible = true;
          });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: new CustomScrollView(
          controller: _controller,
          shrinkWrap: true,
          slivers: <Widget>[
            new SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              sliver: new SliverList(
                delegate: new SliverChildListDelegate(
                  <Widget>[
                    Home(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: _isVisible == true ? 60 : 0,
        child: _isVisible == true
            ? FancyBottomNavigation(
                inactiveIconColor: Colors.grey,
                tabs: [
                  TabData(iconData: FontAwesomeIcons.home, title: "Home"),
                  TabData(iconData: FontAwesomeIcons.chartPie, title: "Stats"),
                  TabData(
                      iconData: FontAwesomeIcons.userAstronaut,
                      title: "Profile"),
                ],
                onTabChangedListener: (position) {
                  setState(() {
                    _currentIndex = position;
                  });
                },
              )
            : Container(
                color: Colors.white,
                width: double.infinity,
              ),
      ),
    );
  }
}
