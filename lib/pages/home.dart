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
        backgroundColor: Colors.pink[800],
        title: Text(
          "BudTrac",
          style: TextStyle(fontFamily: 'EBGaramond', fontSize: 26),
        ),
      ),
      body: ListView(children: [
        Container(
          height: 190,
          // color: Colors.pink[800],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              // children: [Fitur(), Fitur()],
              ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
              // crossAxisAlignment: CrossAxisAlignment.end,
              // children: [Fitur(), Fitur()],
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
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.pink[800],
          onTap: ((value) {
            switch (value) {
              case 1:
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryPage(),
                    ));
                break;
              case 2:
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ));
                break;
            }
          }),
          currentIndex: 0,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.history), label: "History"),
            BottomNavigationBarItem(
                icon: CircleAvatar(
                  backgroundImage: AssetImage('images/profile.png'),
                  radius: 12,
                ),
                label: "Profile"),
          ]),
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
