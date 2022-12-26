import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/history_provider.dart';
import '../widget/detailHistory.dart';

class History extends StatelessWidget {
  Map<String, dynamic> data;
  History({required this.data});

  @override
  Widget build(BuildContext context) {
    final history = Provider.of<HistoryProvider>(context, listen: false);
    final category_image = history.getAllCategory
        .firstWhere((e) => e["name"] == data["category"])["image"];

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.black,
        child: Image.asset(
          category_image,
          width: 30,
        ),
      ),
      title: Text(data['category']),
      subtitle: Text(
          "${DateFormat.yMMMMd("en_us").format(DateTime.parse(data['date']))}"),
      trailing: Text(
        (data["income"] ? '+ ' : '- ') +
            '${data["currency"]} ${data["nominal"]}',
        style: data["income"]
            ? TextStyle(color: Colors.green)
            : TextStyle(color: Colors.red),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => DetailHistory(data),
        );
      },
      // onLongPress: () {},
      // autofocus: true,
      hoverColor: Colors.blueGrey[100],
      // tileColor: Colors.amber,
    );
  }
}
