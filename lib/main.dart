import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/user_provider.dart';
import '../provider/home_provider.dart';
import './pages/splash.dart';

void main() {
  runApp(BudTrac());
}

class BudTrac extends StatelessWidget {
  const BudTrac({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => User(),
        ),
        ChangeNotifierProvider(create: (context) => HomeProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    );
  }
}
