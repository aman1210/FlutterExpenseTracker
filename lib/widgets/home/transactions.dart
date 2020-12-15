import 'dart:io';

import 'package:expenseTracker/Model/transaction.dart';
import 'package:expenseTracker/Provider/profileProvider.dart';
import 'package:expenseTracker/Provider/transactionProvider.dart';
import 'package:expenseTracker/widgets/home/tListItem.dart';
import 'package:expenseTracker/widgets/transactionPage/showReceipt.dart';
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
  final Color green = Color.fromRGBO(34, 206, 98, 1);
  final Color blue = Colors.blue;
  String currency;

  initApp() {
    alltransaction = Provider.of<TransactionProvider>(context).transaction;
    transaction =
        alltransaction.where((element) => element.date.month == month).toList();
    currency = Provider.of<ProfileProvider>(context).currency;
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

  generateDetail(String heading, String info) {
    return Row(
      children: [
        Text(
          '$heading: ',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
        ),
        // SizedBox(
        //   width: 15,
        // ),
        Text(
          info,
          style: TextStyle(fontSize: 18, fontFamily: 'Roboto'),
        ),
      ],
    );
  }

  showDetail(Transaction transaction) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          height: 60,
          color: transaction.transactionType == TransactionType.Income
              ? green
              : blue,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
            child: Text(
              transaction.transactionType == TransactionType.Income
                  ? 'Income Detail'
                  : 'Expense Detail',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  fontFamily: 'Roboto'),
            ),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            generateDetail('Title', transaction.title),
            generateDetail('Amount', '$currency ${transaction.amount}'),
            generateDetail(
                'Time', DateFormat.yMd().add_jm().format(transaction.date)),
            generateDetail('Category', transaction.category),
            if (transaction.imagePath != '')
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Receipt: ',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ShowReceipt(transaction.imagePath),
                        ),
                      );
                    },
                    child: Hero(
                      tag: 'imageHero',
                      child: Image.file(
                        File(transaction.imagePath),
                        width: 100,
                      ),
                    ),
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }

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
            height: 300,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/noData.png',
                  height: 150,
                ),
              ],
            ),
          ),
        if (transaction.length > 0)
          ...transaction.map(
            (e) {
              return InkWell(
                onTap: () {
                  print(e.imagePath);
                  showDetail(e);
                },
                child: TListItem(
                  e: e,
                  cV: changeView,
                ),
              );
            },
          ).toList(),
      ],
    );
  }
}
