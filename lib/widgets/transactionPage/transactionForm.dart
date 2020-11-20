import 'package:expenseTracker/Model/transaction.dart';
import 'package:expenseTracker/Provider/transactionProvider.dart';
import 'package:expenseTracker/widgets/transactionPage/categoryPicker.dart';
import 'package:flutter/material.dart';
import 'package:expenseTracker/widgets/transactionPage/datePicker.dart';
import 'package:expenseTracker/widgets/transactionPage/mainFormEntry.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class TransactionForm extends StatefulWidget {
  TransactionForm({
    Key key,
    @required this.name,
  }) : super(key: key);

  final String name;

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
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

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      constraints: BoxConstraints(minHeight: 800),
      padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60),
          topRight: Radius.circular(60),
        ),
        color: widget.name == 'Income' ? green : blue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          formHeading,
          DatePicker(),
          MainForm(name: widget.name, green: green, blue: blue),
          CategoryPicker(
            name: widget.name,
            green: green,
            blue: blue,
          ),
          Container(
            margin: const EdgeInsets.only(top: 40),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Provider.of<TransactionProvider>(context, listen: false)
                        .cancelTransaction();
                    Navigator.pop(context);
                  },
                  child: Container(
                    child: Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          child: Icon(
                            FontAwesomeIcons.times,
                            color: Colors.black,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(60),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    var msg =
                        Provider.of<TransactionProvider>(context, listen: false)
                            .addTransaction(widget.name == 'Income'
                                ? TransactionType.Income
                                : TransactionType.Expense);
                    if (msg != '') {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text(
                            'Error',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          content: Text(msg),
                          actions: [
                            OutlineButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                Icons.check,
                                color: Colors.black,
                              ),
                              label: Text(
                                'Okay!',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          child: Icon(
                            FontAwesomeIcons.check,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(left: 5, right: 15),
                          child: Text(
                            'Add ${widget.name}',
                            style: TextStyle(color: Colors.black),
                          ),
                        )
                      ],
                    ),
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(60),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
