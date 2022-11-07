import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class User with ChangeNotifier {
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
          "email": email,
          "password": password,
          "createdAt": DateTime.now().toString()
        },
      ),
    );
  }
}
