import 'package:expenseTracker/Provider/profileProvider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DarkModeSwitch extends StatefulWidget {
  const DarkModeSwitch({
    Key key,
  }) : super(key: key);

  @override
  _DarkModeSwitchState createState() => _DarkModeSwitchState();
}

class _DarkModeSwitchState extends State<DarkModeSwitch> {
  var isDark = false;

  switchMode() {
    setState(() {
      isDark = !isDark;
    });
    Provider.of<ProfileProvider>(context, listen: false).toggleDark();
  }

  @override
  void initState() {
    super.initState();
    isDark = Provider.of<ProfileProvider>(context, listen: false).isDark;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            child: Icon(
              FontAwesomeIcons.moon,
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
              child: Text('Dark Mode'),
            ),
          ),
          Switch(
              value: isDark,
              onChanged: (val) {
                switchMode();
              })
        ],
      ),
    );
  }
}
