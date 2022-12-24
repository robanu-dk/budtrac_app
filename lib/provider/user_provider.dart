import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:moneytracker/pages/splash.dart';

class User with ChangeNotifier {
  String _firstName = '',
      _lastName = '',
      _email = '',
      _phone_number = '',
      _image = '',
      _imageUrl = '',
      _firstName_sementara = '',
      _lastName_sementara = '',
      // _email_sementara = '',
      _phone_number_sementara = '';

  var _idToken, _userId, _timer;
  DateTime _expireTime = DateTime.now();

  var _tempIdToken, _tempUserId;
  DateTime _tempExpireTime = DateTime.now();

  void set_firstName_sementara(String firstName) {
    _firstName_sementara = firstName;
    notifyListeners();
  }

  void set_lastName_sementara(String lastName) {
    _lastName_sementara = lastName;
    notifyListeners();
  }

  // void set_email_sementara(String email) {
  //   _email_sementara = email;
  //   notifyListeners();
  // }

  void set_phone_number_sementara(String phone_number) {
    _phone_number_sementara = phone_number;
    notifyListeners();
  }

  String get firstName_sementara => _firstName_sementara;

  String get lastName_sementara => _lastName_sementara;

  String get getImage => _image;

  String get getImageUrl => _imageUrl;

  // String get email_sementara => _email_sementara;

  String get userId => _userId;

  String get phone_number_sementara => _phone_number_sementara;

  String get getFirstName => _firstName;

  String get getLastName => _lastName;

  String get getEmail => _email;

  String get getPhoneNumber => _phone_number;

  bool get isAuth => _idToken != null;

  void updateData() async {
    var _key;

    _firstName =
        (firstName_sementara != '') ? firstName_sementara : getFirstName;
    _lastName = (lastName_sementara != '') ? lastName_sementara : getLastName;
    // _email = (email_sementara != '') ? email_sementara : getEmail;
    _phone_number = (phone_number_sementara != '')
        ? phone_number_sementara
        : getPhoneNumber;

    await http
        .get(Uri.parse(
            'https://bud-track-4652c-default-rtdb.firebaseio.com/user.json?auth=$token'))
        .then((value) {
      var bodyResponse = jsonDecode(value.body) as Map<String, dynamic>;
      bodyResponse.forEach((key, value) {
        if (value["userId"] == uid) {
          _key = key;
        }
      });
    });

    http.patch(
      Uri.parse(
          'https://bud-track-4652c-default-rtdb.firebaseio.com/user/$_key.json?auth=$token'),
      body: jsonEncode({
        "firstName": _firstName,
        "lastName": _lastName,
        "phone_number": _phone_number,
      }),
    );
    notifyListeners();
  }

  void setDataUser(String email, String token) {
    final data = http
        .get(
      Uri.parse(
          'https://bud-track-4652c-default-rtdb.firebaseio.com/user.json?auth=$token'),
    )
        .then((value) {
      final bodyResponse = jsonDecode(value.body) as Map<String, dynamic>;
      bodyResponse.forEach((key, value) {
        if (value['email'] == email) {
          _email = email;
          _firstName = value['firstName'];
          _lastName = value["lastName"];
          _image = value['image'];
          _imageUrl = value['imageUrl'];
          _phone_number = value['phone_number'];
        }
      });
    });
    notifyListeners();
  }

  Future<void> tempData() async {
    _idToken = _tempIdToken;
    _userId = _tempUserId;
    _expireTime = _tempExpireTime;
    notifyListeners();
  }

  get token {
    if (_idToken != null &&
        _expireTime != null &&
        DateTime.now().isBefore(_expireTime)) {
      return _idToken;
    }

    return null;
  }

  get uid {
    if (_idToken != null &&
        _expireTime != null &&
        DateTime.now().isBefore(_expireTime)) {
      return _userId;
    }

    return null;
  }

  Future<void> postData(String firstName, String lastName, String email,
      String password, String token) async {
    await http.post(
      Uri.parse(
          'https://bud-track-4652c-default-rtdb.firebaseio.com/user.json?auth=$token'),
      body: jsonEncode(
        {
          "userId": _userId,
          "firstName": firstName,
          "lastName": lastName,
          "image": 'profile.png',
          "imageUrl": '',
          "phone_number": '',
          "email": email,
          "password": password,
          "createdAt": DateTime.now().toString(),
          "updatedAt": DateTime.now().toString(),
        },
      ),
    );
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _image = 'profile.png';
    _imageUrl = '';
  }

  void updateProfileImage(String image) async {
    var keyUser;
    String ref = image.split('+').first;
    String imageUrl = image.split('+').last;
    await http
        .get(Uri.parse(
            'https://bud-track-4652c-default-rtdb.firebaseio.com/user.json?auth=$token'))
        .then(
      (value) {
        var bodyResponse = jsonDecode(value.body) as Map<String, dynamic>;
        bodyResponse.forEach(
          (key, value) {
            if (value['userId'] == userId) {
              keyUser = key;
            }
          },
        );
      },
    );
    await http.patch(
      Uri.parse(
          'https://bud-track-4652c-default-rtdb.firebaseio.com/user/$keyUser.json?auth=$token'),
      body: jsonEncode({
        "image": ref,
        "imageUrl": imageUrl,
      }),
    );
    _image = ref;
    _imageUrl = imageUrl;
    notifyListeners();
  }

  Future<String> regist(
      String firstName, String lastName, String email, String password) async {
    Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAEA_PvRUC0fHLcH6S_XRUJos_B5RQ7mXI');
    try {
      var response = await http.post(
        url,
        body: jsonEncode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );
      var responseBody = jsonDecode(response.body);

      if (responseBody['error'] != null) {
        throw responseBody['error']['message'];
      }

// Auto login after register account:
      // _tempUserId = responseBody["localId"];
      // _tempIdToken = responseBody["idToken"];
      // _tempExpireTime = DateTime.now().add(
      //   Duration(
      //     seconds: int.parse(responseBody["expiresIn"]),
      //   ),
      // );
      // tempData();
      postData(firstName, lastName, email, password, responseBody["idToken"]);
    } catch (error) {
      return error.toString().replaceAll("_", " ").toLowerCase();
    }
    return '';
  }

  Future<String> login(String email, String password) async {
    Uri url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAEA_PvRUC0fHLcH6S_XRUJos_B5RQ7mXI');
    try {
      var response = await http.post(
        url,
        body: jsonEncode(
          {
            "email": email,
            "password": password,
            "returnSecureToken": true,
          },
        ),
      );
      var responseBody = jsonDecode(response.body);

      if (responseBody['error'] != null) {
        return responseBody['error']['message'];
      }

      setDataUser(responseBody['email'], responseBody['idToken']);

      _tempUserId = responseBody["localId"];
      _tempIdToken = responseBody["idToken"];
      _tempExpireTime = DateTime.now().add(
        Duration(
          seconds: int.parse(responseBody["expiresIn"]),
        ),
      );
      tempData();
    } catch (error) {
      return error.toString();
    }
    return '';
  }

  Future<void> logout(context) async {
    _userId = null;
    _idToken = null;
    notifyListeners();
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => SplashPage(),
    ));
  }

  // void autoLogout(context) {
  //   if (_timer != null) {
  //     _timer.cancel();
  //   }
  //   _timer = Timer(Duration(seconds: 20), () => logout(context));
  // }
}
