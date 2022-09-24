import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import './profile.dart';
import './history.dart';

class Homepage extends StatelessWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[900],
        title: Text(
          "BudTrac",
          style: TextStyle(fontFamily: 'EBGaramond', fontSize: 26),
        ),
      ),
      body: ListView(children: [
        Container(
          height: 190,
          color: Colors.pink[800],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [Fitur(), Fitur()],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.end,
            children: [Fitur(), Fitur()],
          ),
        )
      ]),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8, right: 10),
        child: FloatingActionButton(
          backgroundColor: Colors.pink[800],
          onPressed: () {},
          child: Icon(Icons.add),
        ),
      ),
      persistentFooterButtons: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {},
              child: Column(
                children: [
                  Icon(
                    Icons.home,
                    color: Colors.pink[800],
                  ),
                  Text(
                    "Home",
                    style: TextStyle(color: Colors.pink[800]),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 80, left: 80),
              child: TextButton(
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) => HistoryPage()))),
                child: Column(
                  children: [
                    Icon(
                      Icons.history,
                      color: Colors.grey[850],
                    ),
                    Text(
                      "History",
                      style: TextStyle(color: Colors.grey[850]),
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
    );
  }
}

class Fitur extends StatelessWidget {
  const Fitur({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: IconButton(
          padding: EdgeInsets.all(0),
          iconSize: 195,
          onPressed: () {},
          icon: Container(
            // color: Colors.white,
            width: 195,
            height: 195,
          )),
    );
  }
}
