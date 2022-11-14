import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Income with ChangeNotifier {
  String _currencyCode = "IDR", _currencySymbol = "Rp", _countryFlagCode = "id";
  String _note = '', _media = '';

  void currency({
    required String currencyCode,
    required String currencySymbol,
    required String countryFlagCode,
  }) {
    _currencyCode = currencyCode;
    _currencySymbol = currencySymbol;
    _countryFlagCode = countryFlagCode;
    notifyListeners();
  }

  String get getCurrcencyCode => _currencyCode;

  String get getCurrcencySymbol => _currencySymbol;

  String get getCountryFlagCode => _countryFlagCode;

  void setNote(String note) {
    _note = note;
    notifyListeners();
  }

  void setMedia(String media) {
    _media = media;
    notifyListeners();
  }

  String get getNote => _note;

  String get getMedia => _media;

  void postData({
    required String idUser,
    required String nominal,
    required String wallet,
    required String category,
    required String date,
    String media = '',
  }) {
    Uri url = Uri.parse(
      "https://bud-track-4652c-default-rtdb.firebaseio.com/income.json",
    );
    http.post(
      url,
      body: jsonEncode({
        'idUser': idUser,
        'nominal': nominal,
        'currency': getCurrcencyCode,
        'wallet': wallet,
        'category': category,
        'date': date,
        'note': getNote,
        'media': media
      }),
    );
  }
}
