import 'dart:io';

import 'package:credit_card_slider/card_background.dart';
import 'package:credit_card_slider/card_company.dart';
import 'package:credit_card_slider/card_network_type.dart';
import 'package:credit_card_slider/credit_card_widget.dart';
import 'package:credit_card_slider/validity.dart';
import 'package:expenseTracker/Provider/cardProvider.dart';
import 'package:expenseTracker/widgets/addCard/input_formatter.dart';
import 'package:expenseTracker/widgets/addCard/my_strings.dart';
import 'package:expenseTracker/widgets/addCard/payment_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _formKey = new GlobalKey<FormState>();
  var numberController = new TextEditingController();
  var _paymentCard = PaymentCard();
  var _autoValidate = false;
  String cardHolderName = '';
  String cardNumber = '';
  int validMonth = null;
  int validYear = null;
  CardNetworkType network;
  CardCompany company;

  @override
  void initState() {
    super.initState();
    _paymentCard.type = CardType.Others;
    numberController.addListener(_getCardTypeFrmNumber);
  }

  onSubmit() {
    var isValid = _formKey.currentState.validate();
    if (!isValid) {
      return;
    }
    _formKey.currentState.save();
    var card = CreditCard(
      cardBackground: SolidColorCardBackground(Colors.purple),
      cardHolderName: cardHolderName,
      cardNumber: cardNumber,
      company: company,
      validity: Validity(validThruMonth: validMonth, validThruYear: validYear),
      cardNetworkType: network,
    );
    Provider.of<CardProvider>(context, listen: false).addCard(card);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Card'),
      ),
      body: new Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Icon(
                      FontAwesomeIcons.building,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: DropdownButton<CardCompany>(
                      itemHeight: 80,
                      isExpanded: true,
                      dropdownColor: Colors.grey,
                      items: [
                        DropdownMenuItem(
                          child: CardCompany.axisBank.widget,
                          value: CardCompany.axisBank,
                        ),
                        DropdownMenuItem(
                          child: CardCompany.americanExpress.widget,
                          value: CardCompany.americanExpress,
                        ),
                        DropdownMenuItem(
                          child: CardCompany.citiBank.widget,
                          value: CardCompany.citiBank,
                        ),
                        DropdownMenuItem(
                          child: CardCompany.hdfc.widget,
                          value: CardCompany.hdfc,
                        ),
                        DropdownMenuItem(
                          child: CardCompany.hsbc.widget,
                          value: CardCompany.hsbc,
                        ),
                        DropdownMenuItem(
                          child: CardCompany.icici.widget,
                          value: CardCompany.icici,
                        ),
                        DropdownMenuItem(
                          child: CardCompany.indusland.widget,
                          value: CardCompany.indusland,
                        ),
                        DropdownMenuItem(
                          child: CardCompany.kotak.widget,
                          value: CardCompany.kotak,
                        ),
                        DropdownMenuItem(
                          child: CardCompany.virgin.widget,
                          value: CardCompany.virgin,
                        ),
                        DropdownMenuItem(
                            child: CardCompany.yesBank.widget,
                            value: CardCompany.yesBank),
                      ],
                      onChanged: (value) {
                        setState(() {
                          company = value;
                        });
                      },
                      value: CardCompany.axisBank,
                    ),
                  ),
                ],
              ),
              new TextFormField(
                decoration: const InputDecoration(
                  border: const UnderlineInputBorder(),
                  filled: true,
                  icon: const Icon(
                    Icons.person,
                    // size: 40.0,
                  ),
                  hintText: 'What name is written on card?',
                  labelText: 'Card Name',
                ),
                onSaved: (String value) {
                  setState(() {
                    cardHolderName = value;
                  });
                },
                keyboardType: TextInputType.text,
                validator: (String value) =>
                    value.isEmpty ? Strings.fieldReq : null,
              ),
              new SizedBox(
                height: 30.0,
              ),
              new TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  new LengthLimitingTextInputFormatter(19),
                  new CardNumberInputFormatter()
                ],
                controller: numberController,
                decoration: new InputDecoration(
                  border: const UnderlineInputBorder(),
                  filled: true,
                  icon: Icon(Icons.credit_card),
                  hintText: 'What number is written on card?',
                  labelText: 'Number',
                ),
                onSaved: (String value) {
                  print('onSaved = $value');
                  print('Num controller has = ${numberController.text}');
                  setState(() {
                    cardNumber = value;
                  });
                  // _paymentCard.number = CardUtils.getCleanedNumber(value);
                },
                validator: CardUtils.validateCardNum,
              ),
              new SizedBox(
                height: 30.0,
              ),
              new TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  new LengthLimitingTextInputFormatter(4),
                  new CardMonthInputFormatter()
                ],
                decoration: new InputDecoration(
                  border: const UnderlineInputBorder(),
                  filled: true,
                  icon: Icon(FontAwesomeIcons.calendarAlt),
                  hintText: 'MM/YY',
                  labelText: 'Expiry Date',
                ),
                validator: CardUtils.validateDate,
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  List<int> expiryDate = CardUtils.getExpiryDate(value);
                  _paymentCard.month = expiryDate[0];
                  _paymentCard.year = expiryDate[1];
                  var val = Validity(
                      validThruMonth: expiryDate[0],
                      validThruYear: expiryDate[1]);
                  setState(() {
                    validMonth = expiryDate[0];
                    validYear = expiryDate[1];
                  });
                },
              ),
              new SizedBox(
                height: 50.0,
              ),
              RaisedButton(
                onPressed: () {
                  onSubmit();
                },
                child: Text('Submit'),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    numberController.removeListener(_getCardTypeFrmNumber);
    numberController.dispose();
    super.dispose();
  }

  void _getCardTypeFrmNumber() {
    String input = CardUtils.getCleanedNumber(numberController.text);
    CardType cardType = CardUtils.getCardTypeFrmNumber(input);
    CardNetworkType cardNetwork;
    if (cardType == CardType.Master) {
      cardNetwork = CardNetworkType.mastercard;
    } else if (cardType == CardType.Visa) {
      cardNetwork = CardNetworkType.visa;
    } else if (cardType == CardType.Rupay) {
      cardNetwork = CardNetworkType.rupay;
    } else {
      cardNetwork = CardNetworkType.visaBasic;
    }
    setState(() {
      network = cardNetwork;
    });
  }
}
