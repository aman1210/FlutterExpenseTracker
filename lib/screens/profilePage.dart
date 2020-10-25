import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    var size = mediaQuery.size;
    var top = 150.0;
    var imageRadius = 100.0;
    return Container(
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            height: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/profilebg.jpg'),
                  fit: BoxFit.cover),
            ),
          ),
          Positioned(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.grey[900]
                      : Colors.grey[50],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black38,
                        offset: Offset(0, -4),
                        blurRadius: 8,
                        spreadRadius: 2)
                  ]),
              width: size.width,
              height: size.height - 200,
              child: Center(
                child: Text('hello'),
              ),
            ),
            top: top,
          ),
          Positioned(
            child: Container(
              height: imageRadius,
              width: imageRadius,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(100),
              ),
              child: Container(
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
            top: top - imageRadius / 2,
            left: size.width / 2 - imageRadius / 2,
          ),
        ],
      ),
    );
  }
}
