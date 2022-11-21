import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../provider/history_provider.dart';
import '../navigation/bottom_navigation.dart';
import '../widget/totalMoneyAndDuration.dart';
import '../widget/historyBar.dart';
import '../widget/historyTile.dart';

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final history_data = Provider.of<HistoryProvider>(context, listen: false);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              'History',
              style: TextStyle(fontSize: 24),
            ),
            centerTitle: false,
            backgroundColor: Colors.pink[800],
            bottom: TabBar(
              indicatorWeight: 0.5,
              tabs: [
                Tab(
                  icon: Icon(Icons.all_inbox_outlined),
                  text: 'All',
                ),
                Tab(
                  icon: Icon(Icons.money),
                  text: 'Income',
                ),
                Tab(
                  icon: Icon(Icons.money_off),
                  text: 'Expense',
                )
              ],
              indicator: BoxDecoration(color: Color.fromARGB(255, 235, 28, 97)),
            ),
            actions: [
              Container(
                width: 55,
                child: IconButton(
                    onPressed: () {}, icon: Icon(Icons.filter_alt_sharp)),
              )
            ],
          ),
          body: TabBarView(children: [
            ListView(children: [
              TotalMoneyAndDuration(
                  "Income & Expense", "Rp 200.000", "12/8/2021", "9/8/2022"),
              HistoryBar(),
              Column(
                children: history_data.getHistoryData.map((data) {
                  return Column(
                    children: [
                      History(
                        data,
                      ),
                      HistoryBar()
                    ],
                  );
                }).toList(),
              )
            ]),
            ListView(
              children: [
                TotalMoneyAndDuration(
                    "Income", "Rp 200.000", "12/8/2021", "8/8/2022"),
                HistoryBar(),
                Column(
                  children: history_data.getHistoryData
                      .where((e) => e['income'])
                      .toList()
                      .map((data) {
                    return Column(
                      children: [
                        History(
                          data,
                        ),
                        HistoryBar()
                      ],
                    );
                  }).toList(),
                )
              ],
            ),
            ListView(
              children: [
                TotalMoneyAndDuration(
                    "Expense", "Rp 200.000", "1/8/2022", "9/8/2022"),
                HistoryBar(),
                Column(
                    children: history_data.getHistoryData
                        .where((e) => !e["income"])
                        .toList()
                        .map((data) {
                  return Column(
                    children: [
                      History(
                        data,
                      ),
                      HistoryBar()
                    ],
                  );
                }).toList())
              ],
            ),
          ]),
          bottomNavigationBar: BottomNavigation(1)),
    );
  }
}
