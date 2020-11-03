import 'dart:math' as math;

import 'package:expenseTracker/Model/transaction.dart';
import 'package:expenseTracker/Provider/transactionProvider.dart';
import 'package:expenseTracker/widgets/home/homeHeaderBground.dart';
import 'package:expenseTracker/widgets/home/homeHeaderBalance.dart';
import 'package:expenseTracker/widgets/home/homeHeaderCard.dart';
import 'package:expenseTracker/widgets/home/tListItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:expenseTracker/widgets/home/dragContainer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  List<Transaction> alltransaction = [];
  List<Transaction> transaction = [];
  int month = DateTime.now().month;

  initApp() {
    alltransaction = Provider.of<TransactionProvider>(context).transaction;
    print(alltransaction.length);
    transaction =
        alltransaction.where((element) => element.date.month == month).toList();
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

  changeDate(int i) {
    setState(() {
      month += i;
    });
    Provider.of<TransactionProvider>(context, listen: false)
        .totalBalance(month);
  }

  @override
  void initState() {
    super.initState();
    // initApp();
  }

  @override
  void didUpdateWidget(covariant Home oldWidget) {
    // TODO: implement didUpdateWidget
    // print('hello');
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    print(month);
    initApp();
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;
    var header = AnimatedContainer(
      duration: Duration(milliseconds: 300),
      height: size.height * 0.35,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          HomeHeaderBackground(
            height: size.height * 0.35,
          ),
          HomeHeaderBalance(
            month: month,
          ),
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

    return Container(
      // height: size.height,
      child: Column(
        children: [
          header,
          SizedBox(
            height: 10,
          ),
          DragContainer(size),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(FontAwesomeIcons.arrowCircleLeft),
                onPressed: () {
                  changeDate(-1);
                },
              ),
              Expanded(
                child: Text(
                  'Transactions ${DateTime.now().month == month ? "this month" : "in " + DateFormat.MMMM().format(DateTime(DateTime.now().year, month))}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'TimeBurner',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              IconButton(
                icon: Icon(FontAwesomeIcons.arrowCircleRight),
                onPressed: () {
                  changeDate(1);
                },
              ),
            ],
          ),
          if (transaction.length == 0)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Image.asset(
                  'assets/images/search.png',
                  // fit: BoxFit.contain,
                  height: 200,
                ),
              ),
            ),

          if (transaction.length == 0)
            Text(
              'No Transactions',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'TimeBurner',
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
              ),
            ),
          // if (transaction.length > 0)

          if (transaction.length > 0)
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 20),
                controller: _controller,
                child: Column(
                  children: [
                    ...transaction.map(
                      (e) {
                        return TListItem(
                          e: e,
                          cV: widget.cV,
                        );
                      },
                    ).toList(),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
