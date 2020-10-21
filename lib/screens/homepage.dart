import 'package:expenseTracker/Provider/transactionProvider.dart';
import 'package:expenseTracker/screens/statsPage.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';

import 'package:expenseTracker/screens/home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

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
    List<Widget> _list = [
      FutureBuilder(
          future: Provider.of<TransactionProvider>(context, listen: false)
              .fetchAndSetTransaction(),
          builder: (context, snapshot) => Home(changeVisibility, _isVisible)),
      StatsPage(),
      Center(
        child: Text('profile'),
      ),
    ];
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: _list[_currentIndex],
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
                height: 100,
                color: Colors.white,
                width: double.infinity,
              ),
      ),
    );
  }
}
