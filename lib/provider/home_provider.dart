import 'package:flutter/widgets.dart';

class HomeProvider with ChangeNotifier {
  bool _income = true;

  setIncome() {
    _income = true;
    notifyListeners();
  }

  setExpense() {
    _income = false;
    notifyListeners();
  }

  bool get incomeStatus => _income;
}
