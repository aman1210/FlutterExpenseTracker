import 'dart:math' as math;

import 'package:expenseTracker/Model/transaction.dart';
import 'package:expenseTracker/Provider/transactionProvider.dart';
import 'package:expenseTracker/widgets/home/homeHeaderBground.dart';
import 'package:expenseTracker/widgets/home/homeHeaderBalance.dart';
import 'package:expenseTracker/widgets/home/homeHeaderCard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:expenseTracker/widgets/home/dragContainer.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
    List<Transaction> transaction =
        Provider.of<TransactionProvider>(context).transaction;
    // Provider.of<TransactionProvider>(context).totalBalance;
    var header = AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: size.height * 0.35,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          HomeHeaderBackground(
            visible: widget.visible,
            height: size.height * 0.35,
          ),
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
                    angle: math.pi * 3 / 4,
                  ),
                  HomeHeaderCard(
                    name: 'Earned',
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
                if (transaction.length == 0)
                  Image.asset('assets/images/search.png'),
                if (transaction.length == 0)
                  Text(
                    'No Transactions Yet!!!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                if (transaction.length > 0)
                  ...transaction.map((e) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Icon(
                              IconData(
                                e.icon,
                                fontFamily: e.iconFamily,
                                fontPackage: e.iconPackage,
                              ),
                              color: Colors.white,
                              size: 22,
                            ),
                            backgroundColor:
                                e.transactionType == TransactionType.Income
                                    ? Colors.green
                                    : Colors.red[400],
                            radius: 28,
                          ),
                          title: Text(e.title),
                          subtitle: Text(DateFormat.yMMMd().format(e.date)),
                          trailing: Text('₹ ${e.amount.toString()}'),
                        ),
                      ),
                    );
                  }).toList(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
