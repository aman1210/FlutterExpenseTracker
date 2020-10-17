import 'package:flutter/material.dart';

class MainForm extends StatelessWidget {
  const MainForm({
    Key key,
    @required this.name,
    @required this.green,
    @required this.blue,
  }) : super(key: key);

  final String name;
  final Color green;
  final Color blue;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 30),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  'T',
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
                      color: name == 'Income'
                          ? green.withGreen(180)
                          : blue.withBlue(255).withGreen(170),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "${name.toUpperCase()} TITLE",
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 20,
                        ),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: name == 'Income'
                                ? green.withGreen(120)
                                : blue.withBlue(140).withGreen(120)),
                        border: InputBorder.none),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 30),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Text(
                  '₹',
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
                      color: name == 'Income'
                          ? green.withGreen(180)
                          : blue.withBlue(255).withGreen(170),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "ENTER AMOUNT",
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 20,
                        ),
                        labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: name == 'Income'
                                ? green.withGreen(120)
                                : blue.withBlue(140).withGreen(120)),
                        border: InputBorder.none),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
