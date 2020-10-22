import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expenseTracker/screens/home.dart';
import 'package:expenseTracker/Provider/transactionProvider.dart';
import 'package:expenseTracker/screens/statsPage.dart';
import 'package:expenseTracker/widgets/fluidNavBar/fluid_nav_bar.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _currentIndex = 0;
  var _isVisible = true;

  changeVisibility(bool val) {
    setState(() {
      _isVisible = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _list = [
      FutureBuilder(
          future: Provider.of<TransactionProvider>(context, listen: false)
              .fetchAndSetTransaction(),
          builder: (context, snapshot) => Home(changeVisibility, _isVisible)),
      StatsPage(),
      Center(
        child: Text('profile'),
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.grey[100],
      resizeToAvoidBottomInset: true,
      body: _list[_currentIndex],
      bottomNavigationBar: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        height: _isVisible == true ? 60 : 0,
        child: _isVisible == true
            ? FluidNavBar(onChange: _handleNavigationChange)
            : Container(
                height: 100,
                color: Colors.white,
                width: double.infinity,
              ),
      ),
    );
  }

  void _handleNavigationChange(int selectedIndex) {
    setState(() {
      _currentIndex = selectedIndex;
    });
  }
}
