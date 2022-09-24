import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneytracker/pages/home.dart';
import 'package:moneytracker/pages/profile.dart';

class HistoryPage extends StatelessWidget {
  List<Map<String, dynamic>> database = [
    {
      "title": "food",
      "image": "images/food.jpeg",
      "date":
          DateFormat.yMd().add_jm().format(DateTime(2022, 9, 8, 10, 10, 20)),
      "income": false
    },
    {
      "title": "ride",
      "image": "images/ride.jpeg",
      "date": DateFormat.yMd().add_jm().format(DateTime(2022, 8, 8, 10, 11, 2)),
      "income": true
    },
    {
      "title": "other",
      "image": "images/other.jpeg",
      "date": DateFormat.yMd().add_jm().format(DateTime(2022, 7, 8, 11, 10, 2)),
      "income": false
    },
    {
      "title": "shopping",
      "image": "images/shopping.jpeg",
      "date":
          DateFormat.yMd().add_jm().format(DateTime(2022, 6, 8, 10, 20, 60)),
      "income": true
    },
    {
      "title": "food",
      "image": "images/food.jpeg",
      "date":
          DateFormat.yMd().add_jm().format(DateTime(2022, 5, 8, 10, 10, 20)),
      "income": true
    },
    {
      "title": "other",
      "image": "images/other.jpeg",
      "date":
          DateFormat.yMd().add_jm().format(DateTime(2022, 4, 8, 10, 30, 20)),
      "income": true
    },
    {
      "title": "ride",
      "image": "images/ride.jpeg",
      "date": DateFormat.yMd().add_jm().format(DateTime(2022, 3, 8, 10, 25, 2)),
      "income": false
    },
    {
      "title": "food",
      "image": "images/food.jpeg",
      "date":
          DateFormat.yMd().add_jm().format(DateTime(2022, 2, 8, 10, 15, 20)),
      "income": false
    },
    {
      "title": "food",
      "image": "images/food.jpeg",
      "date":
          DateFormat.yMd().add_jm().format(DateTime(2022, 1, 8, 10, 15, 20)),
      "income": false
    },
    {
      "title": "shopping",
      "image": "images/shopping.jpeg",
      "date":
          DateFormat.yMd().add_jm().format(DateTime(2021, 12, 8, 10, 35, 10)),
      "income": true
    }
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
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
                text: 'Outcome',
              )
            ],
            indicator: BoxDecoration(color: Color.fromARGB(255, 235, 28, 97)),
            // leading: IconButton(icon: Icons.home, onPressed: null),
            // leading: IconButton(onPressed: () {}, icon: Icon(Icons.home)),
          ),
          actions: [
            Container(
              width: 55,
              child: Icon(Icons.filter_alt_sharp),
            )
          ],
        ),
        body: TabBarView(children: [
          ListView(
            children: database.map((data) {
              return Column(
                children: [
                  History(data["title"], data["image"], data["date"],
                      data["income"]),
                  HistoryBar()
                ],
              );
            }).toList(),
          ),
          ListView(
            children: database.map((data) {
              return Column(
                children: [
                  if (data['income'])
                    Column(
                      children: [
                        History(data["title"], data["image"], data["date"],
                            data["income"]),
                        HistoryBar()
                      ],
                    )
                ],
              );
            }).toList(),
          ),
          ListView(
            children: database.map((data) {
              return Column(
                children: [
                  if (!data['income'])
                    Column(
                      children: [
                        History(data["title"], data["image"], data["date"],
                            data["income"]),
                        HistoryBar()
                      ],
                    )
                ],
              );
            }).toList(),
          ),
        ]),
        persistentFooterButtons: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Homepage(),
                    )),
                child: Column(
                  children: [
                    Icon(
                      Icons.home,
                      color: Colors.grey[850],
                    ),
                    Text(
                      "Home",
                      style: TextStyle(color: Colors.grey[850]),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 80, left: 80),
                child: TextButton(
                  onPressed: () => null,
                  child: Column(
                    children: [
                      Icon(
                        Icons.history,
                        color: Colors.pink[800],
                      ),
                      Text(
                        "History",
                        style: TextStyle(color: Colors.pink[800]),
                      )
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => ProfilePage()))),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("images/profile.png"),
                      radius: 12,
                    ),
                    Text(
                      "Profile",
                      style: TextStyle(color: Colors.grey[850]),
                    )
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

class HistoryBar extends StatelessWidget {
  const HistoryBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Divider(
      thickness: 2,
      color: Colors.black12,
    );
  }
}

class History extends StatelessWidget {
  String title, avatarImage, dateTime;
  bool income;

  History(this.title, this.avatarImage, this.dateTime, this.income);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(this.avatarImage),
      ),
      title: Text(this.title),
      subtitle: Text(this.dateTime),
      trailing: Text(
        (this.income ? '+ ' : '- ') + 'Rp 90.000',
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
