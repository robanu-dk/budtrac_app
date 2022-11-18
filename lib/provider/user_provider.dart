import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class User with ChangeNotifier {
  String _firstName = 'Data',
      _lastName = 'Provider',
      _email = 'dataProvider@gmail.com',
      _phone_number = '082011633000',
      _firstName_sementara = '',
      _lastName_sementara = '',
      _email_sementara = '',
      _phone_number_sementara = '';

  void set_firstName_sementara(String firstName) {
    _firstName_sementara = firstName;
    notifyListeners();
  }

  void set_lastName_sementara(String lastName) {
    _lastName_sementara = lastName;
    notifyListeners();
  }

  void set_email_sementara(String email) {
    _email_sementara = email;
    notifyListeners();
  }

  void set_phone_number_sementara(String phone_number) {
    _phone_number_sementara = phone_number;
    notifyListeners();
  }

  String get firstName_sementara => _firstName_sementara;

  String get lastName_sementara => _lastName_sementara;

  String get email_sementara => _email_sementara;

  String get phone_number_sementara => _phone_number_sementara;

  String get getFirstName => _firstName;

  String get getLastName => _lastName;

  String get getEmail => _email;

  String get getPhoneNumber => _phone_number;

  void updateData() {
    _firstName =
        (firstName_sementara != '') ? firstName_sementara : getFirstName;
    _lastName = (lastName_sementara != '') ? lastName_sementara : getLastName;
    _email = (email_sementara != '') ? email_sementara : getEmail;
    _phone_number = (phone_number_sementara != '')
        ? phone_number_sementara
        : getPhoneNumber;
    notifyListeners();
  }

  Future<http.Response> regist(
      String firstName, String lastName, String email, String password) async {
    Uri url = Uri.parse(
        'https://bud-track-4652c-default-rtdb.firebaseio.com/user.json');
    return await http.post(
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
