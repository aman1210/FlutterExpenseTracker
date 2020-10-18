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
  var _isVisible = true;

  changeVisibility(bool val) {
    setState(() {
      _isVisible = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Home(changeVisibility, _isVisible),
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
