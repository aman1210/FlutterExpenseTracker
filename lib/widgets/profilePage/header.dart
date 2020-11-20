import 'dart:io';

import 'package:expenseTracker/Provider/profileProvider.dart';
import 'package:expenseTracker/screens/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProfileProvider>(context);
    return Container(
      height: 250,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/bg9.jpg',
          ),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            blurRadius: 10,
            spreadRadius: 4,
            color: Colors.black38,
          )
        ],
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                child: Text(
                  'Profile',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'TimeBurner',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1,
                      fontSize: 40),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Container(
                      child: provider.path == ''
                          ? Icon(
                              FontAwesomeIcons.user,
                              size: 35,
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              child: Image.file(
                                File(provider.path),
                                fit: BoxFit.cover,
                              ),
                            ),
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          color: Provider.of<ProfileProvider>(context).isDark ==
                                  true
                              ? Theme.of(context).primaryColor
                              : Colors.grey[100],
                          borderRadius: BorderRadius.circular(35)),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                                fontFamily: 'TimeBurner',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            Text(
                              provider.name == ''
                                  ? 'Enter Your Name'
                                  : '${provider.name}',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontFamily: 'TimeBurner',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: CircleAvatar(
                        backgroundColor: Colors.black38,
                        radius: 20,
                        child: IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 20,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => EditProfile(),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
