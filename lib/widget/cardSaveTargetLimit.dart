import 'package:flutter/material.dart';

import '../widget/saveTargetLimit.dart';
import '../widget/alertCannotSave.dart';
import '../provider/target_limit_provider.dart';

class CardSaveTargetLimit extends StatelessWidget {
  const CardSaveTargetLimit({
    Key? key,
    required this.target,
    required this.isTarget,
  }) : super(key: key);

  final TargetLimit target;
  final bool isTarget;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.pink[800],
      shadowColor: Colors.white,
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: IconButton(
        splashRadius: 160,
        iconSize: 28,
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => (target.getNominal == '')
                ? AlertCantSave(incomeExpense: false)
                : SaveTargetLimit(
                    target: isTarget,
                  ),
          );
        },
        icon: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.save,
              color: Colors.white,
            ),
            Text(
              "Save",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
