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
    );
  }
}
