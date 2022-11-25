import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './home.dart';
import './login.dart';
import '../provider/user_provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<User>(context, listen: false).token != null
        ? Timer(
            Duration(seconds: 8),
            () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Homepage()),
            ),
          )
        : Timer(
            Duration(seconds: 8),
            () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Consumer<User>(
                  builder: (context, auth, child) =>
                      auth.token != null ? SplashPage() : LoginPage(),
                ),
              ),
            ),
          );
    // Timer(Duration(seconds: 4), () => runApp(LoginPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 270,
              height: 270,
              child: Image(
                image: AssetImage('images/gif logo.gif'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                'BudTrac',
                style: TextStyle(
                    fontFamily: 'EBGaramond',
                    fontSize: 40,
                    color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                "\"Budget Tracks - Expense Tracker\"",
                style: TextStyle(
                    fontFamily: 'Times', fontSize: 18, color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
