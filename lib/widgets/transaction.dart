import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class MakeTansaction extends StatefulWidget {
  final String name;
  MakeTansaction(this.name);

  @override
  _MakeTansactionState createState() => _MakeTansactionState();
}

class _MakeTansactionState extends State<MakeTansaction> {
  DateTime selectedDate = DateTime.now();
  Color green = Color.fromRGBO(34, 206, 98, 1);
  Color blue = Color.fromRGBO(61, 120, 240, 1);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(FontAwesomeIcons.arrowLeft)),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Add ${widget.name}',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              'Date: ${DateFormat.MMMMEEEEd().format(DateTime.now())}',
              style: TextStyle(
                fontFamily: 'Poppins',
                // fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 20),
              padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(60),
                  topRight: Radius.circular(60),
                ),
                color: widget.name == 'Income' ? green : blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SELECTED DATE:',
                    style: TextStyle(
                      fontFamily: 'TimeBurner',
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${DateFormat.yMMMMEEEEd().format(selectedDate)}',
                        style: TextStyle(
                          fontFamily: 'TimeBurner',
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      GestureDetector(
                        child: Container(
                          margin: const EdgeInsets.only(top: 8.0),
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Icon(FontAwesomeIcons.calendarAlt),
                        ),
                        onTap: () async {
                          final DateTime picked = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.utc(DateTime.now().year, 1),
                            lastDate: DateTime.now(),
                          );
                          if (picked != null && picked != selectedDate)
                            setState(
                              () {
                                selectedDate = picked;
                              },
                            );
                        },
                      ),
                    ],
                  ),
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
                                fontFamily: 'TimeBurner',
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                                color: widget.name == 'Income'
                                    ? green.withGreen(180)
                                    : blue.withBlue(255),
                                borderRadius: BorderRadius.circular(10)),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  labelText:
                                      "${widget.name.toUpperCase()} TITLE",
                                  contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0,
                                    horizontal: 20,
                                  ),
                                  labelStyle: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: green.withGreen(120)),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
