import 'package:expenseTracker/Model/transaction.dart';
import 'package:expenseTracker/Provider/transactionProvider.dart';
import 'package:expenseTracker/widgets/home/tListItem.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Transactions extends StatefulWidget {
  @override
  _TransactionsState createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions> {
  List<Transaction> alltransaction = [];
  List<Transaction> transaction = [];
  int month = DateTime.now().month;

  initApp() {
    alltransaction = Provider.of<TransactionProvider>(context).transaction;
    transaction =
        alltransaction.where((element) => element.date.month == month).toList();
  }

  changeDate(int i) {
    setState(() {
      month += i;
    });
    Provider.of<TransactionProvider>(context, listen: false)
        .totalBalance(month);
  }

  changeView(bool val) {
    if (true) {
      setState(() {});
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   initApp();
  // }

  @override
  Widget build(BuildContext context) {
    initApp();
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
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
        ),
        if (transaction.length == 0)
          Container(
            height: 200,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/noData.png',
                    height: 150,
                  ),
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
                ],
              ),
            ),
          ),
        if (transaction.length > 0)
          ...transaction.map(
            (e) {
              return TListItem(
                e: e,
                cV: changeView,
              );
            },
          ).toList(),
      ],
    );
  }
}
