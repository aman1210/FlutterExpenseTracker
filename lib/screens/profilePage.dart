import 'package:expenseTracker/screens/categories.dart';
import 'package:expenseTracker/widgets/profilePage/darkModeSwitch.dart';
import 'package:flutter/material.dart';
import 'package:expenseTracker/screens/SavedCard.dart';
import 'package:expenseTracker/widgets/profilePage/header.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatelessWidget {
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  child: Icon(
                    FontAwesomeIcons.networkWired,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          const Color.fromRGBO(114, 30, 224, 1),
                          const Color.fromRGBO(160, 46, 185, 1),
                        ],
                        stops: [0.5, 0.9],
                      ),
                      borderRadius: BorderRadius.circular(5)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Manage Categories',
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Container(
                    // margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(
                  icon: Icon(Icons.chevron_right),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ManageCategories(),
                      ),
                    );
                  },
                )),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            decoration: BoxDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  child: Icon(
                    FontAwesomeIcons.creditCard,
                    color: Colors.white,
                  ),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          const Color.fromRGBO(114, 30, 224, 1),
                          const Color.fromRGBO(160, 46, 185, 1),
                        ],
                        stops: [0.5, 0.9],
                      ),
                      borderRadius: BorderRadius.circular(5)),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Saved Cards',
                      textAlign: TextAlign.start,
                    ),
                  ),
                ),
                Container(
                    // margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(
                  icon: Icon(Icons.chevron_right),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SavedCard(),
                      ),
                    );
                  },
                )),
              ],
            ),
          ),
          Expanded(child: Container()),
        ],
      ),
    );
  }
}
