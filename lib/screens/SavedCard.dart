import 'package:credit_card_slider/card_background.dart';
import 'package:credit_card_slider/card_company.dart';
import 'package:credit_card_slider/card_network_type.dart';
import 'package:credit_card_slider/credit_card_slider.dart';
import 'package:credit_card_slider/credit_card_widget.dart';
import 'package:credit_card_slider/validity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SavedCard extends StatefulWidget {
  @override
  _SavedCardState createState() => _SavedCardState();
}

class _SavedCardState extends State<SavedCard> {
  List<CreditCard> _creditCard = [
    new CreditCard(
      cardBackground: SolidColorCardBackground(Colors.purple),
      cardHolderName: 'Aman Srivastava',
      cardNetworkType: CardNetworkType.visa,
      company: CardCompany.sbi,
      validity: Validity(
        validThruMonth: 2,
        validThruYear: 22,
      ),
      // cardNumber: '1234567891011121'
      //     .split(new RegExp('(/d{4})(/d{4})(/d{4})(/d{4})').)
      //     .toString(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final splitSize = 2;
    RegExp exp = new RegExp(r"\d{4}");
    String str = "1234567812345678";
    Iterable<Match> matches = exp.allMatches(str);
    var list = matches.map((m) => int.tryParse(m.group(0)));
    print(list);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: Text('Saved CARD'), actions: [
        IconButton(
          icon: Icon(
            Icons.add,
          ),
          onPressed: () {},
        ),
      ]),
      body: Center(
          child: CreditCardSlider(
        _creditCard,
        repeatCards: RepeatCards.bothDirection,
      )),
    );
  }
}
