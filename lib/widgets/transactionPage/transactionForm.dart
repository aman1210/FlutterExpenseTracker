import 'package:expenseTracker/widgets/transactionPage/categoryPicker.dart';
import 'package:flutter/material.dart';
import 'package:expenseTracker/widgets/transactionPage/datePicker.dart';
import 'package:expenseTracker/widgets/transactionPage/mainFormEntry.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
          color: widget.name == 'Income' ? green : blue,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            formHeading,
            DatePicker(),
            MainForm(name: widget.name, green: green, blue: blue),
            Expanded(
              child: CategoryPicker(
                name: widget.name,
                green: green,
                blue: blue,
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Container(
                          height: 60,
                          width: 60,
                          child: Icon(FontAwesomeIcons.times),
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
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            height: 60,
                            width: 60,
                            child: Icon(FontAwesomeIcons.check),
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 5, right: 15),
                            child: Text('Add ${widget.name}'),
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
      ),
    );
  }
}
