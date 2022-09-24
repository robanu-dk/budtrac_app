import 'package:flutter/material.dart';

import 'pages/splash.dart';

void main() {
  runApp(BudTrac());
}

class BudTrac extends StatelessWidget {
  const BudTrac({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
