import 'package:expenseTracker/Provider/ad_service.dart';
import 'package:expenseTracker/Provider/categoryProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ManageCategories extends StatefulWidget {
  @override
  _ManageCategoriesState createState() => _ManageCategoriesState();
}

class _ManageCategoriesState extends State<ManageCategories> {
  @override
  void initState() {
    super.initState();
    AdMobService.hideBannerAd();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<CategoryProvider>(context);
    var income = provider.incomeCategory;
    var expense = provider.expenseCategory;

    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Categories'),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildheading(Colors.green, 'Income Categories'),
              ...income
                  .map(
                    (e) => ListTile(
                      title: Text(e.categoryName),
                      trailing: e.categoryName == 'Other'
                          ? null
                          : IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                provider.deleteCategory(
                                    e.categoryName, 'Income');
                              },
                            ),
                    ),
                  )
                  .toList(),
              buildheading(Colors.blue, 'Expense Categories'),
              ...expense
                  .map(
                    (e) => ListTile(
                      title: Text(e.categoryName),
                      trailing: e.categoryName == 'Other'
                          ? null
                          : IconButton(
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                provider.deleteCategory(
                                    e.categoryName, 'Income');
                              },
                            ),
                    ),
                  )
                  .toList(),
              Text(
                '*Preloaded categories will return after you restart the app.',
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildheading(Color color, String text) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: color, width: 2),
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
            color: color,
          ),
        ));
  }
}
