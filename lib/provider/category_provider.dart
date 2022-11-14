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

  List<Map<String, dynamic>> _category_expense = [
    {"name": "Food", "image": "images/food.png"},
    {"name": "Drink", "image": "images/drink.png"},
    {"name": "Food & Drink", "image": "images/food and drink.png"},
    {"name": "Shopping", "image": "images/shopping.png"},
    {"name": "Transport", "image": "images/transport.png"},
    {"name": "Home", "image": "images/home.png"},
    {"name": "Bills & Fees", "image": "images/bill.png"},
    {"name": "Netflix", "image": "images/netflix.png"},
    {"name": "Game Payment", "image": "images/game.png"},
    {"name": "Car", "image": "images/car.png"},
    {"name": "Travel", "image": "images/travel.png"},
    {"name": "Family & Personal", "image": "images/family and personal.png"},
    {"name": "Healthcare", "image": "images/healthcare.png"},
    {"name": "Education", "image": "images/education.png"},
    {"name": "Groceries", "image": "images/groceries.png"},
    {"name": "Gifts", "image": "images/gifts.png"},
    {"name": "Sport & Hobbies", "image": "images/sport.png"},
    {"name": "Cosmetics", "image": "images/cosmetic.png"},
    {"name": "Work", "image": "images/work.png"},
    {"name": "Other", "image": "images/other.png"},
  ];

  List<Map<String, dynamic>> get get_category_income => _category_income;

  List<Map<String, dynamic>> get get_category_expense => _category_expense;
}
