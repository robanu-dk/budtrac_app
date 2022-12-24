import 'package:flutter/material.dart';
import 'package:moneytracker/provider/user_provider.dart';
import 'package:provider/provider.dart';

class RegistPage extends StatefulWidget {
  const RegistPage({Key? key}) : super(key: key);

  @override
  State<RegistPage> createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> {
  bool _hide1 = true;
  bool _hide2 = true;
  bool _ischecked = false;
  bool sign = false;
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final retypePassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final regist = Provider.of<User>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.pink[800],
      appBar: null,
      body: ListView(
        children: [
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(95),
                    bottomRight: Radius.circular(95))),
            child: Container(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Text(
                    'Create Account',
                    style: TextStyle(fontSize: 36, fontFamily: 'EBGaramond'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 5),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.87,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: TextField(
                      controller: firstName,
                      textCapitalization: TextCapitalization.sentences,
                      autocorrect: false,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          label: Text('Firstname'),
                          labelStyle: TextStyle(fontSize: 16),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          prefixIcon: Icon(Icons.person_pin_sharp)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.87,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: TextField(
                      controller: lastName,
                      textCapitalization: TextCapitalization.sentences,
                      autocorrect: false,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          label: Text('Lastname'),
                          labelStyle: TextStyle(fontSize: 16),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          prefixIcon: Icon(Icons.person_pin_sharp)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.87,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: TextField(
                      controller: email,
                      textCapitalization: TextCapitalization.none,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                          label: Text('Email'),
                          labelStyle: TextStyle(fontSize: 16),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.lightBlue),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30))),
                          prefixIcon: Icon(Icons.email)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.87,
                    height: MediaQuery.of(context).size.height * 0.14,
                    child: TextField(
                      controller: password,
                      maxLength: 32,
                      textCapitalization: TextCapitalization.none,
                      autocorrect: false,
                      obscureText: _hide1,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        label: Text('Password'),
                        labelStyle: TextStyle(fontSize: 16),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        prefixIcon: Icon(Icons.key),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              if (_hide1) {
                                _hide1 = false;
                              } else {
                                _hide1 = true;
                              }
                            });
                          },
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: _hide1 ? Colors.grey[600] : Colors.pink[800],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.87,
                    height: MediaQuery.of(context).size.height * 0.14,
                    child: TextField(
                      controller: retypePassword,
                      maxLength: 32,
                      textCapitalization: TextCapitalization.none,
                      autocorrect: false,
                      obscureText: _hide2,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        label: Text('Retype Password'),
                        labelStyle: TextStyle(fontSize: 16),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.lightBlue),
                            borderRadius:
                                BorderRadius.all(Radius.circular(30))),
                        prefixIcon: Icon(Icons.key),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              if (_hide2) {
                                _hide2 = false;
                              } else {
                                _hide2 = true;
                              }
                            });
                          },
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: _hide2 ? Colors.grey[600] : Colors.pink[800],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Row(
                    children: [
                      Checkbox(
                        activeColor: Colors.pink[800],
                        value: _ischecked,
                        onChanged: (bool? value) {
                          setState(() {
                            _ischecked = value!;
                          });
                        },
                      ),
                      Text(
                        'Agree to terms & conditions',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                sign
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: SizedBox(
                          width: 56,
                          height: 56,
                          child: RefreshProgressIndicator(
                            strokeWidth: 3,
                            color: Colors.pink[800],
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.pink.shade800),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          shadowColor: Colors.white,
                          child: Container(
                            width: 200,
                            child: TextButton(
                              onPressed: () {
                                signStatChange();
                                Future.delayed(Duration(seconds: 1), () {
                                  if (_ischecked &&
                                      firstName.text != "" &&
                                      email.text != "" &&
                                      password.text != "" &&
                                      retypePassword.text != "") {
                                    if (password.text == retypePassword.text) {
                                      regist
                                          .regist(firstName.text, lastName.text,
                                              email.text, password.text)
                                          .then((value) {
                                        if (value == "") {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Registration Success!!",
                                              ),
                                              duration: Duration(seconds: 2),
                                            ),
                                          );
                                          Navigator.pop(context);
                                        } else {
                                          failedRegistDialog(context, value);
                                        }
                                      });
                                    } else if (!_ischecked) {
                                      failedRegistDialog(context,
                                          "Agree with the terms & conditions should be checked");
                                    } else {
                                      failedRegistDialog(context,
                                          "Password and Retype Password must be same");
                                    }
                                  } else {
                                    failedRegistDialog(context,
                                        "The Firstname, Email, Password and Retype Password fields cannot be empty.");
                                  }
                                });
                              },
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  color: Colors.pink[800],
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
              ]),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already have an account?',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Log in',
                      style: TextStyle(
                          fontFamily: 'EBGaramond',
                          color: Colors.blueAccent,
                          fontSize: 16),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  void signStatChange() {
    return setState(() {
      sign = !sign;
    });
  }

  Future<dynamic> failedRegistDialog(BuildContext context, String content) {
    signStatChange();
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Sign Up Failed!!"),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Try Again"),
          )
        ],
      ),
    );
  }
}
