import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

import './category_provider.dart';

class HistoryProvider with ChangeNotifier {
  List<Map<String, dynamic>> _category = [
    ...Category().get_category_income,
    ...Category().get_category_expense
  ];

  var _token, _userId;

  List<Map<String, dynamic>> _history_data = [
    // {
    //   "name": "Food",
    //   "date":
    //       DateFormat.yMd().add_jm().format(DateTime(2022, 9, 8, 10, 10, 20)),
    //   "value": 90000,
    //   "currency_symbol": "Rp",
    //   "income": false
    // },
    // {
    //   "name": "Travel",
    //   "date":
    //       DateFormat.yMd().add_jm().format(DateTime(2022, 8, 8, 12, 10, 20)),
    //   "value": 250000,
    //   "currency_symbol": "Rp",
    //   "income": false
    // },
    // {
    //   "name": "Salary",
    //   "date": DateFormat.yMd().add_jm().format(DateTime(2022, 8, 1, 8, 10, 20)),
    //   "value": 3000000,
    //   "currency_symbol": "Rp",
    //   "income": true
    // },
    // {
    //   "name": "Gifts",
    //   "date": DateFormat.yMd().add_jm().format(DateTime(2022, 8, 1, 7, 10, 20)),
    //   "value": 100000,
    //   "currency_symbol": "Rp",
    //   "income": true
    // },
    // {
    //   "name": "Car",
    //   "date":
    //       DateFormat.yMd().add_jm().format(DateTime(2022, 7, 8, 10, 11, 20)),
    //   "value": 20000,
    //   "currency_symbol": "Rp",
    //   "income": false
    // },
    // {
    //   "name": "Loan",
    //   "date": DateFormat.yMd().add_jm().format(DateTime(2022, 6, 6, 10, 0, 0)),
    //   "value": 90000000,
    //   "currency_symbol": "Rp",
    //   "income": true
    // },
    // {
    //   "name": "Extra Income",
    //   "date":
    //       DateFormat.yMd().add_jm().format(DateTime(2022, 6, 6, 15, 10, 20)),
    //   "value": 150000,
    //   "currency_symbol": "Rp",
    //   "income": true
    // },
    // {
    //   "name": "Netflix",
    //   "date":
    //       DateFormat.yMd().add_jm().format(DateTime(2022, 6, 6, 20, 10, 20)),
    //   "value": 100000,
    //   "currency_symbol": "Rp",
    //   "income": false
    // },
    // {
    //   "name": "Work",
    //   "date":
    //       DateFormat.yMd().add_jm().format(DateTime(2022, 5, 8, 10, 10, 20)),
    //   "value": 900000,
    //   "currency_symbol": "Rp",
    //   "income": true
    // },
    // {
    //   "name": "Other",
    //   "date":
    //       DateFormat.yMd().add_jm().format(DateTime(2022, 1, 8, 10, 10, 20)),
    //   "value": 90000,
    //   "currency_symbol": "Rp",
    //   "income": false
    // },
    // {
    //   "name": "Other",
    //   "date":
    //       DateFormat.yMd().add_jm().format(DateTime(2021, 12, 8, 10, 10, 20)),
    //   "value": 100000,
    //   "currency_symbol": "Rp",
    //   "income": true
    // }
  ];

  List<Map<String, dynamic>> get getAllCategory => _category;

  List<Map<String, dynamic>> get getHistoryData {
    // print(_history_data);
    return _history_data;
  }

  void updateData(token, uid) {
    _token = token;
    _userId = uid;
    notifyListeners();
  }

  void addHistory() {
    http
        .get(
      Uri.parse(
        "https://bud-track-4652c-default-rtdb.firebaseio.com/money.json?auth=$_token",
      ),
    )
        .then(
      (history) {
        final responseBody = jsonDecode(history.body) as Map<String, dynamic>;
        responseBody.forEach(
          (key, value) {
            if (value['idUser'] == _userId) {
              _history_data.add(value);
            }
          },
        );
      },
    );
  }
}
