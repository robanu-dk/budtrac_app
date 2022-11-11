import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class User with ChangeNotifier {
  String _firstName = 'Data',
      _lastName = 'Provider',
      _email = 'dataProvider@gmail.com',
      _phone_number = '082011633000';

  String get getFirstName => _firstName;

  setFirstName(String firstName) {
    _firstName = firstName;
    notifyListeners();
  }

  String get getLastName => _lastName;

  setLastName(String lastName) {
    _lastName = lastName;
    notifyListeners();
  }

  String get getEmail => _email;

  setEmail(String email) {
    _email = email;
    notifyListeners();
  }

  String get getPhoneNumber => _phone_number;

  setPhoneNumber(phoneNumber) {
    _phone_number = phoneNumber;
    notifyListeners();
  }

  void regist(
      String firstName, String lastName, String email, String password) {
    Uri url = Uri.parse(
        'https://bud-track-4652c-default-rtdb.firebaseio.com/user.json');
    http.post(
      url,
      body: jsonEncode(
        {
          "firstName": firstName,
          "lastName": lastName,
          "image": 'profile.png',
          "email": email,
          "password": password,
          "createdAt": DateTime.now().toString(),
          "updatedAt": DateTime.now().toString()
        },
      ),
    );
  }
}
