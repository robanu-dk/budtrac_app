import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../widget/cardDate.dart';
import '../widget/cardInputNominal.dart';
import '../widget/cardSaveTargetLimit.dart';
import '../provider/target_limit_provider.dart';

class SetTargetPage extends StatelessWidget {
  const SetTargetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final target = Provider.of<TargetLimit>(context, listen: false);

    TextEditingController nominal = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[800],
        title: Text(
          "Set Target",
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            target.resetTimeStart_and_TimeEnd();
            target.setNominal('');
            Navigator.pop(context);
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
              target: target,
              isTarget: true,
            ),
          )
        ],
      ),
    );
  }
}
