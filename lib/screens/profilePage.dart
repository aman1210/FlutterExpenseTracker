import 'package:expenseTracker/screens/SavedCard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;
    var top = 150.0;
    var imageRadius = 100.0;
    return Container(
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            height: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/profilebg.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[800]
                      : Colors.grey[50],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38,
                        offset: Offset(0, -4),
                        blurRadius: 8,
                        spreadRadius: 2)
                  ]),
              width: size.width,
              height: size.height - 200,
              padding: const EdgeInsets.only(top: 60),
              child: Column(
                children: [
                  Text('name'),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black38, width: 1),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Dark Mode'),
                        Switch(value: true, onChanged: (val) {})
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Daily Remainder to add transactions'),
                        Switch(
                          value: false,
                          onChanged: (value) {},
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.black26, width: 1),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Saved Cards',
                          textAlign: TextAlign.start,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: FlatButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SavedCard(),
                                  ));
                            },
                            child: Text('Show'),
                            color: Colors.amber,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            top: top,
          ),
          Positioned(
            child: Container(
              height: imageRadius,
              width: imageRadius,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(100),
              ),
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            top: top - imageRadius / 2,
            left: size.width / 2 - imageRadius / 2,
          ),
        ],
      ),
    );
  }
}
