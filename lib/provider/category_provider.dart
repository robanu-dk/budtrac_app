import 'package:flutter/widgets.dart';

class Category with ChangeNotifier {
  List<Map<String, dynamic>> _category_income = [
    {"name": "Salary", "image": "images/salary.png"},
    {"name": "Business", "image": "images/business.png"},
    {"name": "Extra Income", "image": "images/extra income.png"},
    {"name": "Work", "image": "images/work.png"},
    {"name": "Loan", "image": "images/loan.png"},
    {"name": "Gifts", "image": "images/gifts.png"},
    {"name": "Parent's Inheritance", "image": "images/inheritance.png"},
    {"name": "Insurance", "image": "images/insurance.png"},
    {"name": "Other", "image": "images/other.png"},
  ];

  List<Map<String, dynamic>> get get_category_income => _category_income;
}
