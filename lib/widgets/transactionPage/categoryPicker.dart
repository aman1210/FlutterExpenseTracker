import 'package:flutter/material.dart';

class CategoryPicker extends StatelessWidget {
  const CategoryPicker({
    Key key,
    @required this.name,
  }) : super(key: key);

  final String name;

  @override
  Widget build(BuildContext context) {
    var heading = Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Row(
        children: [
          Text(
            '${name.toUpperCase()} CATEGORY',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            height: 30,
            width: 30,
            margin: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Icon(
              Icons.search,
              size: 20,
            ),
          ),
        ],
      ),
    );
    return Column(
      children: [
        heading,
        Container(
          height: 60,
          width: double.infinity,
          margin: const EdgeInsets.only(top: 20),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60),
                  // color: name=='I'
                ),
                child: Icon(Icons.car_rental),
              );
            },
            itemCount: 5,
          ),
        ),
      ],
    );
  }
}
