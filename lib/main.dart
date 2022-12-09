import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/history_provider.dart';
import 'provider/target_limit_provider.dart';
import 'provider/category_provider.dart';
import 'provider/user_provider.dart';
import 'provider/home_provider.dart';
import 'provider/money_provider.dart';
import 'pages/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BudTrac());
}

class BudTrac extends StatelessWidget {
  const BudTrac({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => User()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => Category()),
        ChangeNotifierProxyProvider<User, Money>(
          create: (context) => Money(),
          update: (context, user, money) =>
              money!..updateData(user.token, user.uid),
        ),
        ChangeNotifierProxyProvider<User, TargetLimit>(
          create: (context) => TargetLimit(),
          update: (context, user, targetLimit) =>
              targetLimit!..updateData(user.token, user.uid),
        ),
        ChangeNotifierProxyProvider<User, HistoryProvider>(
          create: (context) => HistoryProvider(),
          update: (context, user, historyProvider) =>
              historyProvider!..updateData(user.token, user.uid),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashPage(),
      ),
    );
  }
}
