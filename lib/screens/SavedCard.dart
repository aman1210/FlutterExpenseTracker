import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:credit_card_slider/credit_card_slider.dart';
import 'package:credit_card_slider/credit_card_widget.dart';

import 'package:expenseTracker/Provider/ad_service.dart';
import 'package:expenseTracker/Provider/cardProvider.dart';
import 'package:expenseTracker/screens/newCard.dart';

class SavedCard extends StatefulWidget {
  @override
  _SavedCardState createState() => _SavedCardState();
}

class _SavedCardState extends State<SavedCard> {
  List<CreditCard> _creditCard = [];

  @override
  void initState() {
    super.initState();
    AdMobService.hideBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    _creditCard = Provider.of<CardProvider>(context).cards;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Saved Cards'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddCard(),
                ),
              );
            },
          ),
        ],
      ),
      body: _creditCard.length == 0
          ? Center(
              child: Text('No Card Saved Yet!'),
            )
          : Center(
              child: CreditCardSlider(
                _creditCard,
              ),
            ),
    );
  }
}
