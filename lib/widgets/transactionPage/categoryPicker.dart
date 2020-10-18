import 'package:expenseTracker/Provider/transactionProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:expenseTracker/Model/category.dart';
import 'package:expenseTracker/Provider/categoryProvider.dart';
import 'package:expenseTracker/widgets/transactionPage/customCategoryTitle.dart';

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
    visible = false;
    category = Provider.of<CategoryProvider>(context, listen: false)
        .getCategory(widget.name);
  }

  setCategory() {
    if (selectedCategory != 0) {
      Provider.of<TransactionProvider>(context, listen: false).setCategory(
        category[selectedCategory].categoryName,
        category[selectedCategory].icon.codePoint,
        category[selectedCategory].icon.fontFamily,
        category[selectedCategory].icon.fontPackage,
      );
    }
  }

  changeVisibility() {
    setState(() {
      visible = !visible;
    });
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

    var categories = Container(
      height: 90,
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                if (index == 0) {
                  visible = !visible;
                }
                selectedCategory = index;
              });
              setCategory();
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
                    color:
                        selectedCategory == index ? Colors.black : Colors.white,
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
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading,
        categories,

        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          height: visible ? 70 : 0,
          child: CustomCategoryTitle(
            name: widget.name,
            green: widget.green,
            blue: widget.blue,
            changeVisibilty: changeVisibility,
          ),
        ),
        // if (visible) CustomIconPicker()
      ],
    );
  }
}
