import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

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
        ChangeNotifierProvider(create: (ctx) => CategoryProvider()),
        ChangeNotifierProvider(create: (ctx) => TransactionProvider()),
      ],
      child: MaterialApp(
        locale: Locale('en'),
        supportedLocales: [
          Locale('en'),
        ],
        title: 'Expense Tracker',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          accentColor: Colors.amber,
          fontFamily: 'Poppins',
        ),
        home: SplashScreen(),
      ),
    );
  }
}
