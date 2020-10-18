import 'package:flutter/material.dart';

class HomeHeaderBackground extends StatelessWidget {
  final bool visible;
  final double height;
  const HomeHeaderBackground({Key key, this.visible, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      margin: const EdgeInsets.all(0),
      child: AnimatedContainer(
        alignment: Alignment.topCenter,
        height: visible ? height : 0,
        duration: Duration(milliseconds: 250),
        decoration: BoxDecoration(
          image: DecorationImage(
            alignment: Alignment.topCenter,
            image: AssetImage('assets/images/Oheader2.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
      ),
    );
  }
}
