import 'package:expenseTracker/Model/category.dart';
import 'package:expenseTracker/Provider/categoryProvider.dart';
import 'package:expenseTracker/widgets/transactionPage/pickIcon.dart';
import 'package:flutter/material.dart';
import 'package:icon_picker/icon_picker.dart';
import 'package:provider/provider.dart';

class CategoryPicker extends StatefulWidget {
  const CategoryPicker({
    Key key,
    @required this.name,
    @required this.green,
    @required this.blue,
  }) : super(key: key);

  final String name;
  final Color green;
  final Color blue;

  @override
  _CategoryPickerState createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  var selectedCategory;
  List<CategoryModel> category = [];
  var visible = false;

  @override
  void initState() {
    super.initState();
    category = Provider.of<CategoryProvider>(context, listen: false)
        .getCategory(widget.name);
  }

  @override
  Widget build(BuildContext context) {
    var heading = Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Row(
        children: [
          Text(
            '${widget.name.toUpperCase()} CATEGORY',
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading,
        Container(
          height: 90,
          width: double.infinity,
          margin: const EdgeInsets.only(top: 20),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  if (index != 0) {
                    setState(() {
                      selectedCategory = index;
                    });
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => PickIcon(),
                    );
                    // setState(() {
                    //   visible = true;
                    // });
                  }
                },
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: selectedCategory == index
                            ? Colors.white
                            : widget.name == 'Income'
                                ? widget.green.withGreen(230)
                                : widget.blue
                                    .withBlue(210)
                                    .withGreen(200)
                                    .withRed(22),
                        border: index == 0
                            ? Border.all(color: Colors.white, width: 4)
                            : null,
                      ),
                      child: Icon(
                        category[index].icon,
                        color: selectedCategory == index
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        category[index].categoryName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
            itemCount: category.length,
          ),
        ),
        if (visible)
          Container(
            height: 60,
            margin: const EdgeInsets.only(top: 8),
            child: IconPicker(
              initialValue: 'Home',
              icon: Icon(Icons.apps),
            ),
          ),
      ],
    );
  }
}
