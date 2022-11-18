import 'dart:convert';

import 'package:flutter/widgets.dart';

import 'package:http/http.dart' as http;

class TargetLimit with ChangeNotifier {
  String _currencyCode = "IDR",
      _currencySymbol = "Rp",
      _countryFlagCode = "id",
      _nominal = '';

  DateTime _timeStart = DateTime.now(), _timeEnd = DateTime.now();

  void setNominal(String value) {
    _nominal = value;
    notifyListeners();
  }

  String get getNominal => _nominal;

  void resetTimeStart_and_TimeEnd() {
    _timeStart = DateTime.now();
    _timeEnd = DateTime.now();
    notifyListeners();
  }

  void setTimeStart(DateTime timeStart) {
    _timeStart = timeStart;
    notifyListeners();
  }

  void setTimeEnd(DateTime timeEnd) {
    _timeEnd = timeEnd;
    notifyListeners();
  }

  DateTime get getTimeStart => _timeStart;

  DateTime get getTimeEnd => _timeEnd;

  void setCurrency({
    required String currencyCode,
    required String currencySymbol,
    required String countryFlagCode,
  }) {
    _currencyCode = currencyCode;
    _currencySymbol = currencySymbol;
    _countryFlagCode = countryFlagCode;
    notifyListeners();
  }

  String get getCurrencyCode => _currencyCode;

  String get getCurrencySymbol => _currencySymbol;

  String get getCountryFlagCode => _countryFlagCode;

  postTarget({
    required bool target,
  }) {
    Uri url = Uri.parse(
      "https://bud-track-4652c-default-rtdb.firebaseio.com/targetLimit.json",
    );

    http.post(
      url,
      body: jsonEncode({
        "createdAt": DateTime.now().toString(),
        "idUser": 'idUser',
        "nominal": getNominal,
        "currency": getCurrencyCode,
        "dateStart": getTimeStart.toString(),
        "dateEnd": getTimeEnd.toString(),
        "target": target,
      }),
    );
    resetTimeStart_and_TimeEnd();
    setNominal('');
  }
}
