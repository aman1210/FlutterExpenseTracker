import 'package:expenseTracker/Model/transaction.dart';
import 'package:expenseTracker/Provider/transactionProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MainForm extends StatefulWidget {
  const MainForm({
    Key key,
    @required this.name,
    @required this.green,
    @required this.blue,
  }) : super(key: key);

  final String name;
  final Color green;
  final Color blue;

  @override
  _MainFormState createState() => _MainFormState();
}

class _MainFormState extends State<MainForm> {
  TextEditingController _title = TextEditingController();
  TextEditingController _amount = TextEditingController();
  FocusNode _amountNode = FocusNode();
  final _form = GlobalKey<FormState>();
  String title;
  int amount;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _title.dispose();
    _amount.dispose();
    _amountNode.dispose();
  }

  void saveData() {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    Provider.of<TransactionProvider>(context, listen: false)
        .setTitle(title, amount);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _form,
      // autovalidateMode: AutovalidateMode.always,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    'T',
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: widget.name == 'Income'
                            ? widget.green.withGreen(180)
                            : widget.blue.withBlue(255).withGreen(170),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      textCapitalization: TextCapitalization.words,
                      textInputAction: TextInputAction.next,
                      controller: _title,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(_amountNode);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a title!';
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        title = newValue;
                      },
                      decoration: InputDecoration(
                        labelText: "${widget.name.toUpperCase()} TITLE",
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 20,
                        ),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: widget.name == 'Income'
                                ? widget.green.withGreen(120)
                                : widget.blue.withBlue(140).withGreen(120)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 30),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: Text(
                    '₹',
                    style: TextStyle(
                        fontSize: 24,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: widget.name == 'Income'
                            ? widget.green.withGreen(180)
                            : widget.blue.withBlue(255).withGreen(170),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      focusNode: _amountNode,
                      controller: _amount,
                      keyboardType: TextInputType.number,
                      onFieldSubmitted: (_) {
                        saveData();
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the amount.';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        if (int.parse(value) <= 0) {
                          return "Please enter a number greater than 0";
                        }
                        return null;
                      },
                      onSaved: (newValue) {
                        amount = int.parse(newValue);
                      },
                      decoration: InputDecoration(
                        labelText: "ENTER AMOUNT",
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 20,
                        ),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: widget.name == 'Income'
                                ? widget.green.withGreen(120)
                                : widget.blue.withBlue(140).withGreen(120)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
