import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/history_provider.dart';
import 'provider/target_limit_provider.dart';
import 'provider/category_provider.dart';
import 'provider/user_provider.dart';
import 'provider/home_provider.dart';
import 'provider/money_provider.dart';
import 'pages/splash.dart';

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
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => Category()),
        ChangeNotifierProvider(create: (context) => Money()),
        ChangeNotifierProvider(create: (context) => TargetLimit()),
        ChangeNotifierProvider(create: (context) => HistoryProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    );
  }
}
