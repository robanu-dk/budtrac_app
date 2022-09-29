import 'package:flutter/material.dart';
import '../pages/profile.dart';
import '../pages/home.dart';
import '../pages/history.dart';

class BottomNavigation extends StatelessWidget {
  int currentIndex;

  BottomNavigation(this.currentIndex);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
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
            case 2:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: ((context) => ProfilePage())));
              break;
          }
        }),
        currentIndex: this.currentIndex,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(
              icon: CircleAvatar(
                backgroundImage: AssetImage('images/profile.png'),
                radius: 12,
              ),
              label: "Profile"),
        ]);
  }
}
