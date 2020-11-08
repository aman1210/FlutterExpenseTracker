import 'dart:math' as math;

import 'package:expenseTracker/Model/transaction.dart';
import 'package:expenseTracker/Provider/transactionProvider.dart';
import 'package:expenseTracker/widgets/home/homeHeaderBground.dart';
import 'package:expenseTracker/widgets/home/homeHeaderBalance.dart';
import 'package:expenseTracker/widgets/home/homeHeaderCard.dart';
import 'package:expenseTracker/widgets/home/tListItem.dart';
import 'package:flutter/material.dart';

import 'package:expenseTracker/widgets/home/dragContainer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ScrollController _controller;
  // List<Transaction> alltransaction = [];
  // List<Transaction> transaction = [];
  // int month = DateTime.now().month;

  // initApp() {
  //   alltransaction = Provider.of<TransactionProvider>(context).transaction;
  //   transaction =
  //       alltransaction.where((element) => element.date.month == month).toList();
  //   _controller = ScrollController();
  // }

  // changeDate(int i) {
  //   setState(() {
  //     month += i;
  //   });
  //   Provider.of<TransactionProvider>(context, listen: false)
  //       .totalBalance(month);
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   // initApp();
  // }

  // @override
  // void didUpdateWidget(covariant Home oldWidget) {
  //   // TODO: implement didUpdateWidget
  //   // print('hello');
  //   super.didUpdateWidget(oldWidget);
  // }
  double height = 300;
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: size.height * 0.5,
              color: Colors.lightGreen,
            ),
            Positioned(
              bottom: 0,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                constraints: BoxConstraints(
                    maxHeight: size.height - 60 - kBottomNavigationBarHeight,
                    minHeight: size.height - (size.height * 0.40)),
                height: height,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                  color: Colors.white,
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
                            height = size.height - (size.height * 0.40);
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
                        width: double.infinity,
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          child: Text(
                            '_________',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto'),
                            textAlign: TextAlign.center,
                          ),
                          // color: Colors.black54,
                        ),
                        alignment: Alignment.center,
                      ),
                    ),
                    DragContainer(size),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(top: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                              Text('hrllo'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

////  OLD CODE
///
///Column(
//   children: [
//     Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         IconButton(
//           icon: Icon(FontAwesomeIcons.arrowCircleLeft),
//           onPressed: () {
//             changeDate(-1);
//           },
//         ),
//         Expanded(
//           child: Text(
//             'Transactions ${DateTime.now().month == month ? "this month" : "in " + DateFormat.MMMM().format(DateTime(DateTime.now().year, month))}',
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//               fontFamily: 'TimeBurner',
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//         IconButton(
//           icon: Icon(FontAwesomeIcons.arrowCircleRight),
//           onPressed: () {
//             changeDate(1);
//           },
//         ),
//       ],
//     ),
//     if (transaction.length == 0)
//       Expanded(
//         child: Padding(
//           padding: const EdgeInsets.only(top: 30.0),
//           child: Image.asset(
//             'assets/images/search.png',
//             // fit: BoxFit.contain,
//             height: 200,
//           ),
//         ),
//       ),

//     if (transaction.length == 0)
//       Text(
//         'No Transactions',
//         textAlign: TextAlign.center,
//         style: TextStyle(
//           fontSize: 16,
//           fontFamily: 'TimeBurner',
//           fontWeight: FontWeight.bold,
//           letterSpacing: 1,
//         ),
//       ),
//     // if (transaction.length > 0)

//     if (transaction.length > 0)
//       Expanded(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.only(bottom: 20),
//           controller: _controller,
//           child: Column(
//             children: [
//               ...transaction.map(
//                 (e) {
//                   return TListItem(
//                     e: e,
//                   );
//                 },
//               ).toList(),
//             ],
//           ),
//         ),
//       ),
//   ],
// ),
