import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:getwidget/getwidget.dart';

import './regist.dart';
import '../provider/user_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoginPage> {
  Color icon_eye_color = Colors.grey;
  bool hide = true;
  bool login = false;
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[800],
      body: ListView(
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(top: 25),
              child: Column(
                children: [
                  Text(
                    'BudTrac',
                    style: TextStyle(
                        fontSize: 50,
                        fontFamily: "EBGaramond",
                        color: Colors.white),
                  ),
                  Text(
                    "\"Budget Tracks - Expense Tracker\"",
                    style: TextStyle(
                        fontFamily: "Times",
                        color: Color.fromARGB(255, 233, 233, 233),
                        fontSize: 16),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 35),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(95),
                      topRight: Radius.circular(95))),
              child: Container(
                // height: 550,
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.only(top: 35),
                    child: Text(
                      "Log in",
                      style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Times"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 30, bottom: 20, left: 40, right: 40),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      controller: email,
                      autocorrect: false,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30)),
                          prefixIcon: Icon(Icons.email),
                          labelText: "Email"),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 20, left: 40, right: 40),
                    child: TextField(
                      onSubmitted: (_) {
                        setState(() {
                          login = true;
                        });
                        loginFunction(context);
                      },
                      controller: password,
                      autocorrect: false,
                      obscureText: hide,
                      maxLength: 32,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        prefixIcon: Icon(Icons.key),
                        labelText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              if (hide) {
                                icon_eye_color = Colors.pink.shade600;
                                hide = false;
                              } else {
                                icon_eye_color = Colors.grey;
                                hide = true;
                              }
                            });
                          },
                          icon: Icon(
                            Icons.remove_red_eye,
                            color: icon_eye_color,
                          ),
                        ),
                      ),
                    ),
                  ),
                  login
                      ? Container(
                          height: 56,
                          width: 56,
                          child: RefreshProgressIndicator(
                            backgroundColor: Colors.pink[800],
                            color: Colors.white,
                            strokeWidth: 4,
                          ),
                        )
                      : Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                          color: Colors.pink[800],
                          child: TextButton(
                            onPressed: () {
                              setState(() {
                                login = true;
                              });
                              Future.delayed(Duration(seconds: 1), () {
                                loginFunction(context);
                              });
                              // loginFunction(context);
                              // showDialog(
                              //   context: context,
                              //   builder: (context) => GFLoader(
                              //     type: GFLoaderType.android,
                              //     size: 100,
                              //   ),
                              // );
                            },
                            child: Container(
                              height: 30,
                              width: 300,
                              child: Center(
                                child: Text(
                                  "Log in",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have account?"),
                      TextButton(
                          onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistPage())),
                          child: Text("Sign up"))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 20),
                    child: Row(
                      children: [
                        Container(
                          color: Colors.grey,
                          height: 1,
                          width: 120,
                        ),
                        Padding(
                            padding: EdgeInsets.only(left: 6, right: 6),
                            child: Text("Or log in with")),
                        Container(
                          color: Colors.grey,
                          height: 1,
                          width: 120,
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                          side: BorderSide(color: Colors.grey.shade300)),
                      color: Colors.white,
                      child: TextButton(
                        onPressed: () {},
                        child: Container(
                          height: 30,
                          width: 300,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('images/icon google.png'),
                                Padding(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                    "Google",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }

  void loginFunction(BuildContext context) {
    Provider.of<User>(context, listen: false)
        .login(email.text, password.text)
        .then(
      (error) {
        if (error != '') {
          setState(() {
            login = false;
          });
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Login Failed'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Try Again'),
                )
              ],
            ),
          );
        }
      },
    );
  }
}
