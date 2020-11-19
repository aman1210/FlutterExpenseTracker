import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RemainderSwitch extends StatefulWidget {
  @override
  _RemainderSwitchState createState() => _RemainderSwitchState();
}

class _RemainderSwitchState extends State<RemainderSwitch> {
  bool val = false;
  TimeOfDay time = TimeOfDay.now();

  switchMode(bool value) {
    setState(() {
      val = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                child: Icon(
                  FontAwesomeIcons.clock,
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
                  child: Text('Daily Remainder'),
                ),
              ),
              Switch(
                value: val,
                onChanged: (val) {
                  switchMode(val);
                },
              ),
            ],
          ),
          if (val == true)
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Send remainder at:'),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    var newTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    if (newTime != null) {
                      setState(() {
                        time = newTime;
                      });
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 4.0),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                            color: Theme.of(context).accentColor, width: 2),
                      ),
                    ),
                    child: Text(
                      '${time.hour} : ${time.minute}',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'TimeBurner'),
                    ),
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}
