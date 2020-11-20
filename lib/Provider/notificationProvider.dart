import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationProvider extends ChangeNotifier {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();
  bool show = false;
  String storedtime;
  init() {
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

  Future<void> showNotification(String time) async {
    var hour = int.parse(time.split(' ')[0]);
    var min = int.parse(time.split(' ')[1]);
    print(hour);
    print(min);
    // await cancelRemainder();
    show = true;
    storedtime = time;
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata'));
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'repeatDailyAtTime channel id',
      'repeatDailyAtTime channel name',
      'repeatDailyAtTime description',
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);
    var date = DateTime.now();
    var scheduledDate =
        tz.TZDateTime(tz.local, date.year, date.month, date.day, 12, 40);
    // await flutterLocalNotificationsPlugin.zonedSchedule(
    //     0, 'heloo', 's test', scheduledDate, platformChannelSpecifics,
    //     uiLocalNotificationDateInterpretation:
    //         UILocalNotificationDateInterpretation.absoluteTime,
    //     androidAllowWhileIdle: true,
    //     matchDateTimeComponents: DateTimeComponents.time);
    await flutterLocalNotificationsPlugin
        .show(1208, 'test', 'testing', platformChannelSpecifics)
        .catchError((error) {
      print(error);
    });
    // saveData();
  }

  Future<void> cancelRemainder() async {
    flutterLocalNotificationsPlugin.cancelAll();
    show = false;
    storedtime = null;
    // saveData();
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('show', show);
    prefs.setString('time', storedtime);
  }

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('show') || !prefs.containsKey('time')) {
      return false;
    }
    show = prefs.getBool('show');
    storedtime = prefs.getString('time');
  }
}
