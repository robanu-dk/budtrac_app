import 'package:flutter/material.dart';

class AlertCantSave extends StatelessWidget {
  bool incomeExpense;

  AlertCantSave({
    required this.incomeExpense,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(incomeExpense
          ? "Nominal and Category must have value!"
          : "Nominal must have value!"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Ok"),
        )
      ],
    );
  }
}
