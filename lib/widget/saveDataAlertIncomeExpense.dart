import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/money_provider.dart';
import '../pages/home.dart';

class SaveData extends StatelessWidget {
  final String nominal;
  final String purchase;
  final Map<String, dynamic> chosen_category;
  final DateTime date;
  final bool income;

  const SaveData({
    Key? key,
    required this.nominal,
    required this.purchase,
    required this.chosen_category,
    required this.date,
    required this.income,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final income = Provider.of<Money>(context, listen: false);

    return AlertDialog(
      title: Text("Are you sure to save the data?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('No')),
        TextButton(
          onPressed: () {
            income.postData(
              idUser: 'idUser',
              nominal: nominal,
              wallet: purchase,
              category: chosen_category['name'],
              date: date.toString(),
              income: this.income,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Save Successfull!!"),
                duration: Duration(seconds: 2),
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Homepage(),
              ),
            );
          },
          child: Text('Yes'),
        )
      ],
    );
  }
}
