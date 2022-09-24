import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:moneytracker/pages/history.dart';
import 'package:moneytracker/pages/home.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[800],
        title: Text("Profile", style: TextStyle(fontSize: 24)),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(children: [
          Container(
            height: 400,
            color: Colors.red,
          ),
          Container(
            height: 400,
            color: Colors.blue,
          )
        ]),
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.pink[800],
          onTap: ((value) {
            switch (value) {
              case 0:
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Homepage(),
                    ));
                break;
              case 1:
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HistoryPage(),
                    ));
                break;
            }
          }),
          currentIndex: 2,
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
