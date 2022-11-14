import 'package:flutter/material.dart';

class AlertCantSave extends StatelessWidget {
  const AlertCantSave({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Nominal and Category must have value!"),
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
