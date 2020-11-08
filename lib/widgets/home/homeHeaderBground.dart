import 'package:flutter/material.dart';

class HomeHeaderBackground extends StatelessWidget {
  final double height;
  const HomeHeaderBackground({Key key, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        image: DecorationImage(
          alignment: Alignment.topCenter,
          image: AssetImage('assets/images/bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
