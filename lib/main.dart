import 'package:expenseTracker/Provider/cardProvider.dart';
import 'package:expenseTracker/Provider/notificationProvider.dart';
import 'package:expenseTracker/Provider/profileProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:expenseTracker/Provider/categoryProvider.dart';
import 'package:expenseTracker/Provider/transactionProvider.dart';
import 'package:expenseTracker/screens/splashScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx) => ProfileProvider()),
        ChangeNotifierProvider(create: (ctx) => CategoryProvider()),
        ChangeNotifierProvider(create: (ctx) => TransactionProvider()),
        ChangeNotifierProvider(create: (ctx) => CardProvider()),
        ChangeNotifierProvider(create: (ctx) => NotificationProvider()),
      ],
      child: Consumer<ProfileProvider>(builder: (context, value, _) {
        return MaterialApp(
          locale: Locale('en'),
          supportedLocales: [
            Locale('en'),
          ],
          title: 'Expense Tracker',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: value.isDark ? Brightness.dark : Brightness.light,
            primarySwatch: Colors.indigo,
            accentColor: Colors.lime,
            fontFamily: 'Poppins',
          ),
          home: SplashScreen(),
        );
      }),
    );
  }
}
