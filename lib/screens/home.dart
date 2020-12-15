import 'dart:math' as math;

import 'package:expenseTracker/widgets/home/homeHeaderBalance.dart';
import 'package:expenseTracker/widgets/home/homeHeaderCard.dart';
import 'package:expenseTracker/widgets/home/transactions.dart';
import 'package:flutter/material.dart';

import 'package:expenseTracker/widgets/home/dragContainer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double height = 300;
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // print(size.height);
    return Scaffold(
      body: Container(
        height: size.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: size.height * 0.4,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/bg9.jpg',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                // alignment: Alignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HomeHeaderBalance(
                    month: DateTime.now().month,
                  ),
                  SizedBox(
                    height: size.height * 0.008,
                  ),
                  Container(
                    width: size.width,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        HomeHeaderCard(
                          name: 'Spent',
                          angle: -math.pi * 1 / 4,
                        ),
                        HomeHeaderCard(
                          name: 'Earned',
                          angle: math.pi * 1 / 4,
                        ),
                      ],
                    ),
                  ),
                  if (size.height < 685)
                    SizedBox(
                      height: 20,
                    )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                constraints: BoxConstraints(
                    maxHeight: size.height - 60 - kBottomNavigationBarHeight,
                    minHeight: size.height - (size.height * 0.42)),
                height: height,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      blurRadius: 20,
                      spreadRadius: 0,
                      offset: Offset(0, -5),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    GestureDetector(
                      onPanUpdate: (details) {
                        // print('hello');
                        setState(() {
                          height -= details.delta.dy;
                        });
                      },
                      onPanEnd: (details) {
                        if (expanded) {
                          setState(() {
                            height = size.height - (size.height * 0.42);
                            expanded = false;
                          });
                        } else {
                          setState(() {
                            height = size.height;
                            expanded = true;
                          });
                        }
                      },
                      child: Container(
                        height: 30,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        width: double.infinity,
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: Icon(expanded
                              ? FontAwesomeIcons.chevronDown
                              : FontAwesomeIcons.chevronUp),
                          // color: Colors.black54,
                        ),
                        alignment: Alignment.center,
                      ),
                    ),
                    DragContainer(size),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        child: SingleChildScrollView(child: Transactions()),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
