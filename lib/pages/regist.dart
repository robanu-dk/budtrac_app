import 'package:flutter/material.dart';

class RegistPage extends StatefulWidget {
  const RegistPage({Key? key}) : super(key: key);

  @override
  State<RegistPage> createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> {
  bool _hide1 = true;
  bool _hide2 = true;
  bool _ischecked = false;
  @override
  Widget build(BuildContext context) {
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
                height: MediaQuery.of(context).size.width * 1.45,
                child: Column(children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: Text(
                      'Create Account',
                      style: TextStyle(fontSize: 36, fontFamily: 'EBGaramond'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.87,
                      height: MediaQuery.of(context).size.height * 0.1,
                      child: TextField(
                        textCapitalization: TextCapitalization.sentences,
                        autocorrect: false,
                        keyboardType: TextInputType.name,
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.87,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: TextField(
                      textCapitalization: TextCapitalization.sentences,
                      autocorrect: false,
                      keyboardType: TextInputType.name,
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.87,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: TextField(
                      textCapitalization: TextCapitalization.none,
                      autocorrect: false,
                      keyboardType: TextInputType.emailAddress,
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
                  Container(
                    width: MediaQuery.of(context).size.width * 0.87,
                    height: MediaQuery.of(context).size.height * 0.11,
                    child: TextField(
                      maxLength: 32,
                      textCapitalization: TextCapitalization.none,
                      autocorrect: false,
                      obscureText: _hide1,
                      keyboardType: TextInputType.emailAddress,
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
                                color: _hide1
                                    ? Colors.grey[600]
                                    : Colors.pink[800],
                              ))),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.87,
                      height: MediaQuery.of(context).size.height * 0.11,
                      child: TextField(
                        maxLength: 32,
                        textCapitalization: TextCapitalization.none,
                        autocorrect: false,
                        obscureText: _hide2,
                        keyboardType: TextInputType.emailAddress,
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
                                  color: _hide2
                                      ? Colors.grey[600]
                                      : Colors.pink[800],
                                ))),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5),
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
                  Card(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.pink.shade800),
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    shadowColor: Colors.white,
                    child: Container(
                      width: 200,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20)))),
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
        ));
  }
}
