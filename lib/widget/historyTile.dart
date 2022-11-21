import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/history_provider.dart';

class History extends StatelessWidget {
  Map<String, dynamic> data;

  History(this.data);

  @override
  Widget build(BuildContext context) {
    final history = Provider.of<HistoryProvider>(context, listen: false);
    final category = history.getAllCategory;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.black,
        child: Image.asset(
          category.firstWhere((e) => e['name'] == data['name'])['image'],
          width: 30,
        ),
      ),
      title: Text(data['name']),
      subtitle: Text(data['date']),
      trailing: Text(
        (data["income"] ? '+ ' : '- ') +
            '${data["currency_symbol"]} ${data["value"]}',
        style: data["income"]
            ? TextStyle(color: Colors.green)
            : TextStyle(color: Colors.red),
      ),
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            insetPadding: EdgeInsets.all(10),
            title: Text('Detail Information'),
            content: Container(
                width: MediaQuery.of(context).size.width * 1,
                height: MediaQuery.of(context).size.height * 1,
                child: Text('sd')),
            actions: [Text('sd')],
          ),
        );
      },
      // onLongPress: () {},
      // autofocus: true,
      hoverColor: Colors.blueGrey[100],
      // tileColor: Colors.amber,
    );
  }
}
