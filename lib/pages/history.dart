import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../navigation/bottom_navigation.dart';
import '../widget/totalMoneyAndDuration.dart';
import '../widget/historyBar.dart';
import '../widget/historyTile.dart';

class HistoryPage extends StatelessWidget {
  Map<String, dynamic> category_image = {
    "Food": "images/food.png",
    "Drink": "images/drink.png",
    "Food & Drink": "images/food and drink.png",
    "Shopping": "images/shopping.png",
    "Transport": "images/transport.png",
    "Home": "images/home.png",
    "Bills & Fees": "images/bill.png",
    "Netflix": "images/netflix.png",
    "Game Payment": "images/game.png",
    "Car": "images/car.png",
    "Travel": "images/travel.png",
    "Family & Personal": "images/family and personal/png",
    "Healthcare": "images/healthcare.png",
    "Education": "images/education.png",
    "Groceries": "images/groceries.png",
    "Gifts": "images/gifts.png",
    "Sport & Hobbies": "images/sport.png",
    "Cosmetics": "images/cosmetic.png",
    "Work": "images/work.png",
    "Other": "images/other.png",
    "Salary": "images/salary.png",
    "Business": "images/business.png",
    "Extra Income": "images/extra income.png",
    "Loan": "images/loan.png",
    "Parent's Inheritance": "images/inheritance.png",
    "Insurance": "images/insurance.png"
  };
  List<Map<String, dynamic>> database = [
    {
      "name": "Food",
      "date":
          DateFormat.yMd().add_jm().format(DateTime(2022, 9, 8, 10, 10, 20)),
      "value": 90000,
      "currency_symbol": "Rp",
      "income": false
    },
    {
      "name": "Travel",
      "date":
          DateFormat.yMd().add_jm().format(DateTime(2022, 8, 8, 12, 10, 20)),
      "value": 250000,
      "currency_symbol": "Rp",
      "income": false
    },
    {
      "name": "Salary",
      "date": DateFormat.yMd().add_jm().format(DateTime(2022, 8, 1, 8, 10, 20)),
      "value": 3000000,
      "currency_symbol": "Rp",
      "income": true
    },
    {
      "name": "Gifts",
      "date": DateFormat.yMd().add_jm().format(DateTime(2022, 8, 1, 7, 10, 20)),
      "value": 100000,
      "currency_symbol": "Rp",
      "income": true
    },
    {
      "name": "Car",
      "date":
          DateFormat.yMd().add_jm().format(DateTime(2022, 7, 8, 10, 11, 20)),
      "value": 20000,
      "currency_symbol": "Rp",
      "income": false
    },
    {
      "name": "Loan",
      "date": DateFormat.yMd().add_jm().format(DateTime(2022, 6, 6, 10, 0, 0)),
      "value": 90000000,
      "currency_symbol": "Rp",
      "income": true
    },
    {
      "name": "Extra Income",
      "date":
          DateFormat.yMd().add_jm().format(DateTime(2022, 6, 6, 15, 10, 20)),
      "value": 150000,
      "currency_symbol": "Rp",
      "income": true
    },
    {
      "name": "Netflix",
      "date":
          DateFormat.yMd().add_jm().format(DateTime(2022, 6, 6, 20, 10, 20)),
      "value": 100000,
      "currency_symbol": "Rp",
      "income": false
    },
    {
      "name": "Work",
      "date":
          DateFormat.yMd().add_jm().format(DateTime(2022, 5, 8, 10, 10, 20)),
      "value": 900000,
      "currency_symbol": "Rp",
      "income": true
    },
    {
      "name": "Other",
      "date":
          DateFormat.yMd().add_jm().format(DateTime(2022, 1, 8, 10, 10, 20)),
      "value": 90000,
      "currency_symbol": "Rp",
      "income": false
    },
    {
      "name": "Other",
      "date":
          DateFormat.yMd().add_jm().format(DateTime(2021, 12, 8, 10, 10, 20)),
      "value": 100000,
      "currency_symbol": "Rp",
      "income": true
    }
  ];

  @override
  Widget build(BuildContext context) {
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
                children: database.map((data) {
                  return Column(
                    children: [
                      History(
                          data["name"],
                          category_image[data["name"]],
                          data["date"],
                          data["value"],
                          data["currency_symbol"],
                          data["income"]),
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
                  children: database.map((data) {
                    return Column(
                      children: [
                        if (data['income'])
                          Column(
                            children: [
                              History(
                                  data["name"],
                                  category_image[data["name"]],
                                  data["date"],
                                  data["value"],
                                  data["currency_symbol"],
                                  data["income"]),
                              HistoryBar()
                            ],
                          )
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
                    children: database.map((data) {
                  return Column(
                    children: [
                      if (!data['income'])
                        Column(
                          children: [
                            History(
                                data["name"],
                                category_image[data["name"]],
                                data["date"],
                                data["value"],
                                data["currency_symbol"],
                                data["income"]),
                            HistoryBar()
                          ],
                        )
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
