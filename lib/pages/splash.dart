import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:getwidget/getwidget.dart';

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
    if (Provider.of<User>(context, listen: false).token != null) {
      Timer(Duration(seconds: 1), () {
        setState(() {
          persentage += 0.1;
        });
      });
      Timer(Duration(seconds: 3), () {
        setState(() {
          persentage += 0.2;
        });
      });
      Timer(Duration(seconds: 5), () {
        setState(() {
          persentage += 0.2;
        });
      });
      Timer(Duration(seconds: 7), () {
        setState(() {
          persentage += 0.5;
        });
      });
      Timer(
        Duration(seconds: 8),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Homepage()),
        ),
      );
    } else {
      Timer(
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
    }

    // Timer(Duration(seconds: 4), () => runApp(LoginPage()));
  }

  double persentage = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[800],
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Provider.of<User>(context, listen: false).token == null
              ? Column(
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
                            fontFamily: 'Times',
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: Orientation.landscape ==
                              MediaQuery.of(context).orientation
                          ? 200
                          : 270,
                      height: Orientation.landscape ==
                              MediaQuery.of(context).orientation
                          ? 200
                          : 270,
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
                            fontFamily: 'Times',
                            fontSize: 18,
                            color: Colors.white),
                      ),
                    ),
                    Orientation.landscape == MediaQuery.of(context).orientation
                        ? Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: GFProgressBar(
                              alignment: MainAxisAlignment.center,
                              progressBarColor: Colors.white,
                              width: 300.0,
                              lineHeight: 20.0,
                              percentage: persentage,
                              animation: true,
                              animateFromLastPercentage: true,
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.only(top: 100.0),
                            child: GFProgressBar(
                              alignment: MainAxisAlignment.center,
                              progressBarColor: Colors.white,
                              width: 300.0,
                              lineHeight: 20.0,
                              percentage: persentage,
                              animation: true,
                              animateFromLastPercentage: true,
                            ),
                          )
                  ],
                ),
        ),
      ),
    );
  }
}
