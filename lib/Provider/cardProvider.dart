import 'dart:math';

import 'package:credit_card_slider/card_background.dart';
import 'package:credit_card_slider/card_company.dart';
import 'package:credit_card_slider/card_network_type.dart';
import 'package:credit_card_slider/credit_card_widget.dart';
import 'package:credit_card_slider/validity.dart';
import 'package:expenseTracker/helper/card_helper.dart';
import 'package:flutter/material.dart';

class CardProvider with ChangeNotifier {
  List<CardBackground> _background = [
    GradientCardBackground(
      LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Colors.blue[300],
          Colors.pink[300],
        ],
      ),
    ),
    GradientCardBackground(
      LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xff08AEEA),
          Color(0xff2AF598),
        ],
      ),
    ),
    GradientCardBackground(
      LinearGradient(
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
        colors: [
          Color(0xffDE6262),
          Color(0xffFFB88C),
        ],
      ),
    ),
    SolidColorCardBackground(Colors.black87),
    SolidColorCardBackground(Colors.blue),
    SolidColorCardBackground(Colors.lime),
  ];
  List<CreditCard> cards = [];

  CardCompany checkCardCompany(String s) {
    switch (s) {
      case 'axis':
        return CardCompany.axisBank;
      case 'american':
        return CardCompany.americanExpress;
      case 'bob':
        return CardCompany.bob;
      case 'citi':
        return CardCompany.citiBank;
      case 'hdfc':
        return CardCompany.hdfc;
      case 'hsbc':
        return CardCompany.hsbc;
      case 'icici':
        return CardCompany.icici;
      case 'indusland':
        return CardCompany.indusland;
      case 'kotak':
        return CardCompany.kotak;
      case 'sbi':
        return CardCompany.sbi;
      case 'virgin':
        return CardCompany.virgin;
      default:
        return CardCompany.yesBank;
    }
  }

  CardNetworkType getNetwork(String s) {
    switch (s) {
      case 'visa':
        return CardNetworkType.visa;
      case 'mastercard':
        return CardNetworkType.mastercard;
      case 'rupay':
        return CardNetworkType.rupay;
      default:
        return CardNetworkType.visaBasic;
    }
  }

  Future<void> fetchAndSetCards() async {
    final cardList = await CardHelper.getData();
    var random = Random();
    cardList.forEach((c) {
      var company = checkCardCompany(c['company']);
      var network = getNetwork(c['network']);
      cards.insert(
          0,
          CreditCard(
            cardBackground: _background[random.nextInt(_background.length)],
            cardHolderName: c['name'],
            cardNetworkType: network,
            company: company,
            cardNumber: c['cardnumber'],
            validity: Validity(
              validThruMonth: c['month'],
              validThruYear: c['year'],
            ),
          ));
    });
    notifyListeners();
    // var newCard = CreditCard(
    //   cardBackground: _background[random.nextInt(_background.length)],
    //   cardHolderName: c['name'],
    //   cardNetworkType: network,
    //   company: card,
    //   cardNumber: c['cardnumber'],
    //   validity: Validity(
    //     validThruMonth: c['month'],
    //     validThruYear: c['year'],
    //   ),
    // );
    // return newCard;
  }

  String companyName(CardCompany c) {
    if (c == CardCompany.axisBank) {
      return 'axis';
    } else if (c == CardCompany.americanExpress) {
      return 'american';
    } else if (c == CardCompany.bob) {
      return 'bob';
    } else if (c == CardCompany.citiBank) {
      return 'citi';
    } else if (c == CardCompany.hdfc) {
      return 'hdfc';
    } else if (c == CardCompany.hsbc) {
      return 'hsbc';
    } else if (c == CardCompany.icici) {
      return 'icici';
    } else if (c == CardCompany.indusland) {
      return 'indusland';
    } else if (c == CardCompany.kotak) {
      return 'kotak';
    } else if (c == CardCompany.sbi) {
      return 'sbi';
    } else if (c == CardCompany.virgin) {
      return 'virgin';
    } else {
      return 'yes';
    }
  }

  String networkName(CardNetworkType s) {
    if (s == CardNetworkType.visa) {
      return 'visa';
    } else if (s == CardNetworkType.mastercard) {
      return 'mastercard';
    } else if (s == CardNetworkType.rupay) {
      return 'rupay';
    } else {
      return 'visabasic';
    }
  }

  void addCard(CreditCard card) {
    cards.add(card);
    notifyListeners();
    CardHelper.addCard(
      name: card.cardHolderName,
      company: companyName(card.company),
      month: card.validity.validThruMonth,
      year: card.validity.validThruYear,
      number: card.cardNumber,
      network: networkName(card.cardNetworkType),
    );
  }
}
