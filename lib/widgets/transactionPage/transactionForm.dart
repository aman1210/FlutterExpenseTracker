import 'package:expenseTracker/widgets/transactionPage/categoryPicker.dart';
import 'package:flutter/material.dart';
import 'package:expenseTracker/widgets/transactionPage/datePicker.dart';
import 'package:expenseTracker/widgets/transactionPage/mainFormEntry.dart';

class TransactionForm extends StatelessWidget {
  TransactionForm({
    Key key,
    @required this.name,
  }) : super(key: key);

  final String name;

  final Color green = Color.fromRGBO(34, 206, 98, 1);
  final Color blue = Colors.blue;
  @override
  Widget build(BuildContext context) {
    var formHeading = Text(
      'SELECTED DATE:',
      style: TextStyle(
        fontFamily: 'Roboto',
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: Colors.white,
      ),
    );

    return Expanded(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(60),
            topRight: Radius.circular(60),
          ),
          color: name == 'Income' ? green : blue,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            formHeading,
            DatePicker(),
            MainForm(name: name, green: green, blue: blue),
            CategoryPicker(
              name: name,
              green: green,
              blue: blue,
            ),
          ],
        ),
      ),
    );
  }
}
