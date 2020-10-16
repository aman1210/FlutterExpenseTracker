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
                    'SELECT DATE',
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
                        lastDate: DateTime.utc(DateTime.now().year, 12, 31),
                      );
                      if (picked != null && picked != selectedDate)
                        setState(() {
                          selectedDate = picked;
                        });
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
