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
    // TODO: implement initState
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
