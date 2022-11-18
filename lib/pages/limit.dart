import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../pages/home.dart';
import '../provider/target_limit_provider.dart';
import '../widget/cardSaveTargetLimit.dart';
import '../widget/cardInputNominal.dart';
import '../widget/cardDate.dart';

class SetLimitsPage extends StatelessWidget {
  const SetLimitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final limit = Provider.of<TargetLimit>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[800],
        title: Text(
          "Set Limit",
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
            limit.resetTimeStart_and_TimeEnd();
            limit.setNominal('');
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: [
          CardInputNominal(),
          CardDate(
            isStart: true,
          ),
          CardDate(
            isStart: false,
          ),
          Padding(
              padding: const EdgeInsets.only(top: 30.0, left: 50, right: 50),
              child: CardSaveTargetLimit(
                target: limit,
                isTarget: false,
              ))
        ],
      ),
    );
  }
}
