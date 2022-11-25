import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class Money with ChangeNotifier {
  String _currencyCode = "IDR",
      _currencySymbol = "Rp",
      _countryFlagCode = "id",
      _nominal = '';
  String _note = '', _media = '';

  var _token, _userId;

  void updateData(tokenData, uid) {
    _token = tokenData;
    _userId = uid;
    notifyListeners();
  }

  void setNominal(String value) {
    _nominal = value;
    notifyListeners();
  }

  String get getNominal => _nominal;

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

  Future<http.Response> postData({
    required String nominal,
    required String wallet,
    required String category,
    required String date,
    String media = '',
    required bool income,
  }) async {
    Uri url = Uri.parse(
      "https://bud-track-4652c-default-rtdb.firebaseio.com/money.json?auth=$_token",
    );
    return await http.post(
      url,
      body: jsonEncode({
        'createdAt': DateTime.now().toString(),
        'idUser': _userId,
        'nominal': nominal,
        'currency': getCurrcencyCode,
        'wallet': wallet,
        'category': category,
        'date': date,
        'note': getNote,
        'media': media,
        'income': income
      }),
    );
  }
}
