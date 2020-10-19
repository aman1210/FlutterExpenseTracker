import 'package:expenseTracker/Provider/categoryProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomCategoryTitle extends StatefulWidget {
  const CustomCategoryTitle({
    Key key,
    @required this.name,
    @required this.green,
    @required this.blue,
    @required this.changeVisibilty,
  }) : super(key: key);

  final String name;
  final Color blue;
  final Color green;
  final Function changeVisibilty;

  @override
  _CustomCategoryTitleState createState() => _CustomCategoryTitleState();
}

class _CustomCategoryTitleState extends State<CustomCategoryTitle> {
  TextEditingController _category = TextEditingController();
  final _form = GlobalKey<FormState>();
  String title;
  @override
  void dispose() {
    super.dispose();
    _category.dispose();
  }

  saveForm() {
    var isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    Provider.of<CategoryProvider>(context, listen: false)
        .addCategory(title, widget.name);
    _form.currentState.reset();
    widget.changeVisibilty();
  }

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
              child: Form(
                key: _form,
                child: TextFormField(
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.done,
                  controller: _category,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter the title';
                    }
                    return null;
                  },
                  onFieldSubmitted: (value) {
                    setState(() {
                      title = value;
                    });
                    saveForm();
                  },
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
          ),
        ],
      ),
    );
  }
}
