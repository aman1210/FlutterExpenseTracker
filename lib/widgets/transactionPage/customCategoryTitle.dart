import 'package:flutter/material.dart';

class CustomCategoryTitle extends StatefulWidget {
  const CustomCategoryTitle({
    Key key,
    @required this.name,
    @required this.green,
    @required this.blue,
  }) : super(key: key);

  final String name;
  final Color blue;
  final Color green;

  @override
  _CustomCategoryTitleState createState() => _CustomCategoryTitleState();
}

class _CustomCategoryTitleState extends State<CustomCategoryTitle> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
              'C',
              style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                  color: widget.name == 'Income'
                      ? widget.green.withGreen(180)
                      : widget.blue.withBlue(255).withGreen(170),
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: "CATEGORY TITLE",
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 20,
                    ),
                    labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: widget.name == 'Income'
                            ? widget.green.withGreen(120)
                            : widget.blue.withBlue(140).withGreen(120)),
                    border: InputBorder.none),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
