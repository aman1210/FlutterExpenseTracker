import 'dart:io';

import 'package:flutter/material.dart';

class ShowReceipt extends StatelessWidget {
  final image;
  ShowReceipt(this.image);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          // Navigator.pop(context);
        },
        child: Center(
          child: InteractiveViewer(
            minScale: 0.5,
            child: Hero(
              tag: 'imageHero',
              child: Image.file(
                File(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
