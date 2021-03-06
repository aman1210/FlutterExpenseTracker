import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:expenseTracker/Provider/profileProvider.dart';

class RemainderSwitch extends StatefulWidget {
  @override
  _RemainderSwitchState createState() => _RemainderSwitchState();
}

class _RemainderSwitchState extends State<RemainderSwitch> {
  bool val = false;
  TimeOfDay time = TimeOfDay(hour: 22, minute: 00);

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  Future showNotification(String msg) async {
    var hour = int.parse(msg.split(' ')[0]);
    var min = int.parse(msg.split(' ')[1]);
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    var scheduledDate = tz.TZDateTime(tz.local, 2020, DateTime.now().month,
        DateTime.now().day + 1, hour, min);
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'repeatDailyAtTime channel id',
      'repeatDailyAtTime channel name',
      'repeatDailyAtTime description',
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(0, 'Daily Remainder',
        "Add today's transactions", scheduledDate, platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time);
    Provider.of<ProfileProvider>(context, listen: false)
        .toggleNoti(scheduledDate.toIso8601String());
  }

  init() async {
    var provider = Provider.of<ProfileProvider>(context, listen: false);
    val = provider.showNoti;
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    if (provider.time != '' && provider.time != null) {
      var date = tz.TZDateTime.parse(tz.local, provider.time);

      time = TimeOfDay(hour: date.hour, minute: date.minute);
    }
  }

  @override
  void initState() {
    super.initState();
    init();
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    var initializationSettingsAndroid = AndroidInitializationSettings(
      'app_icon',
    );
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
                onChanged: (value) async {
                  var newtime;
                  if (value == true) {
                    newtime = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay(hour: 22, minute: 0),
                    );

                    showNotification('${newtime.hour} ${newtime.minute}');
                  } else {
                    flutterLocalNotificationsPlugin.cancelAll();
                    Provider.of<ProfileProvider>(context, listen: false)
                        .toggleNoti('');
                  }
                  setState(() {
                    time = newtime;
                    val = value;
                  });
                },
              ),
            ],
          ),
          if (val == true)
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 45),
                    child: Text('Send remainder at:'),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    var newTime = await showTimePicker(
                        context: context, initialTime: TimeOfDay.now());
                    if (newTime != null) {
                      flutterLocalNotificationsPlugin.cancelAll();
                      showNotification('${newTime.hour} ${newTime.minute}');
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
                      '${time.hour < 10 ? '0' : ''}${(time.hour)} : ${time.minute < 10 ? '0' : ''}${time.minute}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
