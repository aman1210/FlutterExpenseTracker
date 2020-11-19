import 'package:expenseTracker/Provider/ad_service.dart';
import 'package:expenseTracker/widgets/profilePage/remainderSwitch.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:expenseTracker/screens/categories.dart';
import 'package:expenseTracker/widgets/profilePage/darkModeSwitch.dart';
import 'package:expenseTracker/screens/SavedCard.dart';
import 'package:expenseTracker/widgets/profilePage/header.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    // FirebaseAdMob.instance.initialize(
    //   appId: BannerAd.testAdUnitId,
    // );
    // AdMobService.showBannerAd();
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
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
                    ).then((value) => AdMobService.showBannerAd());
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
                    ).then((value) => AdMobService.showBannerAd());
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
