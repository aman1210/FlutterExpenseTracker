import 'package:expenseTracker/Provider/notificationProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class RemainderSwitch extends StatefulWidget {
  @override
  _RemainderSwitchState createState() => _RemainderSwitchState();
}

class _RemainderSwitchState extends State<RemainderSwitch> {
  bool val = false;
  TimeOfDay time = TimeOfDay.now();

  // Future<void> switchMode(bool value) async {
  //   setState(() {
  //     val = value;
  //   });
  //   if (value == true) {
  //     var newTime =
  //         await showTimePicker(context: context, initialTime: TimeOfDay.now());
  //     if (newTime != null) {
  //       setState(() {
  //         time = newTime;
  //       });
  //       Provider.of<NotificationProvider>(context, listen: false)
  //           .showNotification('${time.hour} ${time.minute}');
  //     }
  //   }
  //   if (value = false) {
  //     Provider.of<NotificationProvider>(context, listen: false)
  //         .cancelRemainder();
  //   }
  // }
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  Future showNotification(String msg) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
    var scheduledDate = tz.TZDateTime(tz.local, 2020, 11, 20, 11, 00);
    print(tz.local);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'repeatDailyAtTime channel id',
      'repeatDailyAtTime channel name',
      'repeatDailyAtTime description',
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0, 'heloo', 's test', scheduledDate, platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  @override
  void initState() {
    super.initState();
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid = AndroidInitializationSettings(
      'app_icon',
    ); // <- default icon name is @mipmap/ic_launcher
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: showNotification);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                onChanged: (value) {
                  if (value == true) {
                    showNotification('hello');
                  } else {
                    flutterLocalNotificationsPlugin.cancelAll();
                  }
                  setState(() {
                    val = value;
                  });
                },
              ),
              // RaisedButton(
              //   onPressed: () {
              //     showNotification('hello');
              //   },
              //   child: Text('Show'),
              // )
            ],
          ),
          // if (val == true)
          //   Row(
          //     children: [
          //       Expanded(
          //         child: Padding(
          //           padding: const EdgeInsets.all(8.0),
          //           child: Text('Send remainder at:'),
          //         ),
          //       ),
          //       GestureDetector(
          //         onTap: () async {
          //           var newTime = await showTimePicker(
          //               context: context, initialTime: TimeOfDay.now());
          //           if (newTime != null) {
          //             setState(() {
          //               time = newTime;
          //             });
          //           }
          //         },
          //         child: Container(
          //           padding: const EdgeInsets.symmetric(
          //               horizontal: 8.0, vertical: 4.0),
          //           decoration: BoxDecoration(
          //             border: Border(
          //               bottom: BorderSide(
          //                   color: Theme.of(context).accentColor, width: 2),
          //             ),
          //           ),
          //           child: Text(
          //             '${(time.hour) % 12} : ${time.minute}${time.period.index == 0 ? 'am' : 'pm'}',
          //             style: TextStyle(
          //               fontSize: 18,
          //               fontWeight: FontWeight.bold,
          //             ),
          //           ),
          //         ),
          //       )
          //     ],
          //   ),
        ],
      ),
    );
  }
}
