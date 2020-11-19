import 'package:flutter/material.dart';

import 'package:expenseTracker/screens/home.dart';
import 'package:expenseTracker/screens/statsPage.dart';
import 'package:expenseTracker/screens/profilePage.dart';
import 'package:expenseTracker/widgets/fluidNavBar/fluid_nav_bar.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _currentIndex = 0;
  FlutterLocalNotificationsPlugin flutterLocalNotificationPlugin;

  @override
  void initState() {
    super.initState();
    // var initializationSettingsAndroid =
    //     new AndroidInitializationSettings('app_icon');
    // var initializationSettingsIos = new IOSInitializationSettings();
    // var initializationSettings = InitializationSettings(
    //     android: initializationSettingsAndroid, iOS: initializationSettingsIos);
    // flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();
    // flutterLocalNotificationPlugin.initialize(initializationSettings,onSelectNotification: onSelectNotification);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _list = [
      Home(),
      StatsPage(),
      ProfilePage(),
    ];
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: true,
      body: _list[_currentIndex],
      bottomNavigationBar: Container(
          height: 60, child: FluidNavBar(onChange: _handleNavigationChange)),
    );
  }

  void _handleNavigationChange(int selectedIndex) {
    setState(() {
      _currentIndex = selectedIndex;
    });
  }
}
