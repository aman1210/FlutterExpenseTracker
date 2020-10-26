import 'package:credit_card_slider/card_background.dart';
import 'package:credit_card_slider/card_company.dart';
import 'package:credit_card_slider/card_network_type.dart';
import 'package:credit_card_slider/credit_card_widget.dart';
import 'package:credit_card_slider/validity.dart';
import 'package:flutter/material.dart';

class CardProvider with ChangeNotifier {
  List<CreditCard> cards = [
    CreditCard(
      cardBackground: SolidColorCardBackground(Colors.purple),
      cardHolderName: 'Aman Srivastava',
      cardNetworkType: CardNetworkType.visa,
      company: CardCompany.sbi,
      validity: Validity(
        validThruMonth: 2,
        validThruYear: 22,
      ),
    ),
  ];

  void addCard(CreditCard card) {
    cards.add(card);
    notifyListeners();
  }
}
