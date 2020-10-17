import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    Key key,
  }) : super(key: key);

  @override
  _DatePickerState createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
