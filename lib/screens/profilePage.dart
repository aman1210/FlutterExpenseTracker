import 'package:expenseTracker/Provider/profileProvider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:expenseTracker/screens/faqScreen.dart';
import 'package:expenseTracker/screens/categories.dart';
import 'package:expenseTracker/screens/SavedCard.dart';
import 'package:expenseTracker/widgets/profilePage/remainderSwitch.dart';
import 'package:expenseTracker/widgets/profilePage/darkModeSwitch.dart';
import 'package:expenseTracker/widgets/profilePage/header.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ProfileHeader(),
          SizedBox(
            height: 20,
          ),
          DarkModeSwitch(),
          RemainderSwitch(),
          buildOption(
            context: context,
            icon: FontAwesomeIcons.networkWired,
            title: 'Manage Categories',
            widget: ManageCategories(),
          ),
          buildOption(
            context: context,
            icon: FontAwesomeIcons.coins,
            title: 'Change Currency',
          ),
          buildOption(
            context: context,
            icon: FontAwesomeIcons.creditCard,
            title: 'Saved Cards',
            widget: SavedCard(),
          ),
          buildOption(
            context: context,
            widget: FAQScreen(),
            icon: FontAwesomeIcons.questionCircle,
            title: 'FAQ',
          ),
        ],
      ),
    );
  }

  void selectCurrency() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.all(8),
            // height: 255,
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                createCurrency(index: 1, name: 'Rupee', symbol: '₹'),
                createCurrency(index: 2, name: 'Dollar', symbol: '\$'),
                createCurrency(index: 3, name: 'Euro', symbol: '€'),
                createCurrency(index: 4, name: 'Pound', symbol: '£'),
                createCurrency(index: 5, name: 'Yen', symbol: '¥'),
              ],
            ),
          ),
        );
      },
    );
  }

  GestureDetector buildOption(
      {BuildContext context, Widget widget, IconData icon, String title}) {
    return GestureDetector(
      onTap: () {
        if (title == 'Change Currency') {
          selectCurrency();
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => widget,
            ),
          );
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 40,
              width: 40,
              child: Icon(
                icon,
                color: Colors.white,
              ),
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [Colors.lightBlue, Colors.blue[800]],
                    // stops: [0.4, 0.9],
                  ),
                  borderRadius: BorderRadius.circular(5)),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                ),
              ),
            ),
            Container(
              child: IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () {
                  if (title == 'Change Currency') {
                    selectCurrency();
                  } else {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => widget,
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  InkWell createCurrency({int index, String symbol, String name}) {
    return InkWell(
      onTap: () {
        Provider.of<ProfileProvider>(context, listen: false)
            .changeCurreny(symbol);
        Navigator.pop(context);
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey[300], width: 2),
          ),
          color: Provider.of<ProfileProvider>(context).currency ==symbol? Theme.of(context).accentColor.withOpacity(0.4):index % 2 != 0
              ? Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[800]
                  : Colors.white
              : Theme.of(context).brightness == Brightness.dark
                  ? Colors.grey[600]
                  : Colors.grey[200],
        ),
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: Center(
                child: Text(
                  symbol,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto'
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 3,
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
