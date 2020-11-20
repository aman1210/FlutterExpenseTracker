import 'package:expenseTracker/Provider/profileProvider.dart';
import 'package:expenseTracker/Provider/transactionProvider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeHeaderCard extends StatelessWidget {
  final double angle;
  final String name;

  const HomeHeaderCard({
    Key key,
    @required this.name,
    @required this.angle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var amount;
    var symbol = Provider.of<ProfileProvider>(context).currency;
    if (name == 'Earned') {
      amount = Provider.of<TransactionProvider>(context).earned;
    } else {
      amount = Provider.of<TransactionProvider>(context).spent;
    }
    return Card(
      elevation: 15,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
        height: 100,
        width: 160,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Transform.rotate(
                angle: angle,
                child: Icon(
                  FontAwesomeIcons.arrowRight,
                  size: 15,
                  color: Colors.deepOrange,
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'TimeBurner',
                      fontWeight: FontWeight.bold,
                      color: Colors.grey),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$symbol ',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w600,
                          color: Colors.grey),
                    ),
                    Text(
                      amount.toString(),
                      style: TextStyle(
                          fontSize: 26,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
