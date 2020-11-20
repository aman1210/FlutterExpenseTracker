import 'package:flutter/material.dart';

class FAQScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextStyle question = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
    TextStyle answer = TextStyle(fontSize: 16, fontFamily: 'Roboto');

    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '\u2022 How to add transactions?',
              style: question,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                'Slide the circle with 6 dots towards left or right to add income or expense respectively.',
                style: answer,
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              '\u2022 How to delete transactions?',
              style: question,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                'Slide the transaction that you want to delete in the right direction.',
                style: answer,
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              '\u2022 How to add new category?',
              style: question,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                'In transaction form tap on the icon which says other and type in the name of new category and then tap on Add button.',
                style: answer,
              ),
            ),
            SizedBox(
              height: 14,
            ),
            Text(
              '\u2022 Is it safe to add card?',
              style: question,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14.0),
              child: Text(
                'Since the app is completely offline and all the data is stored in the devices itself, it is completely safe to add card.',
                style: answer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
