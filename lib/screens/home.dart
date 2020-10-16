import 'dart:math' as math;

import 'package:expenseTracker/widgets/home/homeHeaderBground.dart';
import 'package:expenseTracker/widgets/home/homeHeaderBalance.dart';
import 'package:expenseTracker/widgets/home/homeHeaderCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:expenseTracker/widgets/home/dragContainer.dart';

class Home extends StatefulWidget {
  final Function cV;
  final bool visible;
  Home(this.cV, this.visible);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _controller;
  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
        if (widget.visible) {
          widget.cV(false);
        }
      }
      if (_controller.position.userScrollDirection == ScrollDirection.forward) {
        if (!widget.visible)
          setState(() {
            widget.cV(true);
          });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;
    var header = AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: widget.visible ? size.height * 0.35 : 0,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          HomeHeaderBackground(),
          HomeHeaderBalance(),
          Positioned(
            bottom: -30,
            child: Container(
              width: size.width,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  HomeHeaderCard(
                    name: 'Spent',
                    amount: 500,
                    angle: math.pi * 3 / 4,
                  ),
                  HomeHeaderCard(
                    name: 'Earned',
                    amount: 500,
                    angle: -math.pi * 1 / 4,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
    return CustomScrollView(
      controller: _controller,
      shrinkWrap: true,
      slivers: <Widget>[
        new SliverPadding(
          padding: const EdgeInsets.all(0),
          sliver: new SliverList(
            delegate: new SliverChildListDelegate(
              <Widget>[
                header,
                SizedBox(
                  height: 10,
                ),
                DragContainer(size),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
