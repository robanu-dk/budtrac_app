import 'package:flutter/material.dart';

import '../widget/historyBar.dart';

class TotalMoneyAndDuration extends StatelessWidget {
  String category, timeStart, timeEnd, money;
  TotalMoneyAndDuration(
      this.category, this.money, this.timeStart, this.timeEnd);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Total: " + this.category,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            this.money,
            style: TextStyle(fontFamily: "DoppioOne", color: Colors.pink[900]),
          ),
          HistoryBar(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.47,
                child: Column(
                  children: [
                    Text("Time Start:",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(this.timeStart,
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
              ),
              Container(
                width: 2,
                height: 32,
                color: Colors.black12,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.47,
                child: Column(
                  children: [
                    Text("Time End:",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(this.timeEnd,
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
