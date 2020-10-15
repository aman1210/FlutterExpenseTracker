import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:expenseTracker/widgets/dragContainer.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 100),
        height: 70,
        child: DragContainer(size),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 20,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.grid_on), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.card_membership), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        currentIndex: 0,
        unselectedIconTheme: IconThemeData(color: Colors.grey),
        selectedIconTheme: IconThemeData(color: Colors.amber),
        type: BottomNavigationBarType.fixed,
      ),
      floatingActionButton: Transform.rotate(
        angle: math.pi / 4,
        child: Container(
          margin: EdgeInsets.only(bottom: 10),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(6),
            boxShadow: [
              BoxShadow(
                color: Colors.black38,
                offset: Offset(4, 4),
                spreadRadius: -2,
                blurRadius: 4,
              ),
            ],
          ),
          child: Transform.rotate(
            angle: -math.pi / 4,
            child: Icon(
              Icons.card_giftcard,
              color: Colors.white,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
