import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/target_limit_provider.dart';

class CardDate extends StatelessWidget {
  bool isStart;

  CardDate({
    required this.isStart,
  });

  @override
  Widget build(BuildContext context) {
    final targetAndLimit = Provider.of<TargetLimit>(context, listen: false);

    return Card(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Colors.grey.shade300,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(2),
        ),
      ),
      child: Consumer<TargetLimit>(
        builder: (context, value, child) => IconButton(
          splashRadius:
              MediaQuery.of(context).orientation == Orientation.landscape
                  ? 350
                  : 210,
          iconSize: 50,
          onPressed: () {
            showDatePicker(
              context: context,
              initialDate: isStart
                  ? targetAndLimit.getTimeStart
                  : targetAndLimit.getTimeEnd,
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
            ).then((value) {
              isStart
                  ? targetAndLimit.setTimeStart(value!)
                  : targetAndLimit.setTimeEnd(value!);
            });
          },
          icon: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    size: 28,
                  ),
                  Text(" Date ${isStart ? 'Start' : 'End'}"),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 7.5),
                child: Text(
                    "${DateFormat.yMMMMd("en_us").format(isStart ? targetAndLimit.getTimeStart : targetAndLimit.getTimeEnd)}"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
