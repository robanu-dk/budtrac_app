import 'package:flutter/material.dart';

class History extends StatelessWidget {
  String title, avatarImage, dateTime, currency_symbol;
  bool income;
  int value;

  History(this.title, this.avatarImage, this.dateTime, this.value,
      this.currency_symbol, this.income);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.black,
        child: Image.asset(
          this.avatarImage,
          width: 30,
        ),
      ),
      title: Text(this.title),
      subtitle: Text(this.dateTime),
      trailing: Text(
        (this.income ? '+ ' : '- ') + '${this.currency_symbol} ${this.value}',
        style: this.income
            ? TextStyle(color: Colors.green)
            : TextStyle(color: Colors.red),
      ),
      onTap: () {},
      // onLongPress: () {},
      // autofocus: true,
      hoverColor: Colors.blueGrey[100],
      // tileColor: Colors.amber,
    );
  }
}
