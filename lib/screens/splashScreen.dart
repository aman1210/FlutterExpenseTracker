import 'dart:async';

import 'package:expenseTracker/Provider/cardProvider.dart';
import 'package:expenseTracker/Provider/categoryProvider.dart';
import 'package:expenseTracker/Provider/notificationProvider.dart';
import 'package:expenseTracker/Provider/transactionProvider.dart';
import 'package:expenseTracker/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  loadImages() async {
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.of(context).pushReplacement(_createRoute());
      },
    );
  }

  @override
  void initState() {
    loadImages();
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false)
        .fetchAndSetTransaction();
    Provider.of<CategoryProvider>(context, listen: false).fetchAndSetCategory();
    Provider.of<CardProvider>(context, listen: false).fetchAndSetCards();
    Provider.of<NotificationProvider>(context, listen: false).getData();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Container(
          // width: double.infinity,
          // color: Colors.deepPurple,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                LottieBuilder.asset(
                  'assets/images/saving.json',
                  frameRate: FrameRate.max,
                  width: width.width * 0.8,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => MyHomePage(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(1.0, 0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
