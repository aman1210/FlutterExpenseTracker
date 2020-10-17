import 'package:expenseTracker/widgets/transactionPage/transactionForm.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class MakeTansaction extends StatelessWidget {
  final String name;
  MakeTansaction(this.name);
  @override
  Widget build(BuildContext context) {
    var backArrow = Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(FontAwesomeIcons.arrowLeft)),
    );
    var title = Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(
        'Add $name',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
    );
    var titleDate = Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(
        'Date: ${DateFormat.MMMMEEEEd().format(DateTime.now())}',
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 18,
        ),
      ),
    );
    return Container(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          backArrow,
          SizedBox(
            height: 20,
          ),
          title,
          titleDate,
          TransactionForm(
            name: name,
          ),
        ],
      ),
    );
  }
}
