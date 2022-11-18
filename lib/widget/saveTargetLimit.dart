import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/target_limit_provider.dart';
import '../pages/home.dart';

class SaveTargetLimit extends StatelessWidget {
  bool target;

  SaveTargetLimit({required this.target});

  @override
  Widget build(BuildContext context) {
    final targetLimit = Provider.of<TargetLimit>(context, listen: false);

    return AlertDialog(
      title: Text("Save Data?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('No'),
        ),
        TextButton(
          onPressed: () {
            targetLimit.postTarget(
              target: this.target,
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Save Successful!!'),
                duration: Duration(seconds: 2),
              ),
            );
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => Homepage(),
              ),
            );
          },
          child: Text('Save'),
        ),
      ],
    );
  }
}
