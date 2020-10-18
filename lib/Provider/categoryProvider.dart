import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../Model/category.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> expenseCategory = [
    new CategoryModel(icon: Icons.add, categoryName: 'Other'),
    new CategoryModel(icon: FontAwesomeIcons.car, categoryName: 'Automobile'),
    new CategoryModel(icon: Icons.business_center, categoryName: 'Business'),
    new CategoryModel(icon: Icons.fastfood, categoryName: 'Food'),
    new CategoryModel(icon: Icons.movie, categoryName: 'Movie'),
    new CategoryModel(icon: Icons.medical_services, categoryName: 'Medical'),
    new CategoryModel(
        icon: FontAwesomeIcons.shoppingBasket, categoryName: 'Shopping'),
  ];

  List<CategoryModel> incomeCategory = [
    new CategoryModel(icon: Icons.add, categoryName: 'Other'),
    new CategoryModel(
        icon: FontAwesomeIcons.moneyCheck, categoryName: 'Salary'),
    new CategoryModel(icon: FontAwesomeIcons.trophy, categoryName: 'Reward'),
    new CategoryModel(icon: FontAwesomeIcons.coins, categoryName: 'Cashback')
  ];

  List<CategoryModel> getCategory(String name) {
    if (name == 'Income') {
      return incomeCategory;
    }
    return expenseCategory;
  }

  void addCategory(String title, String listName) {
    if (listName == 'Income') {
      incomeCategory.insert(
        1,
        new CategoryModel(categoryName: title, icon: FontAwesomeIcons.userCog),
      );
    } else {
      expenseCategory.insert(
        1,
        new CategoryModel(categoryName: title, icon: FontAwesomeIcons.userCog),
      );
    }
    notifyListeners();
  }
}
