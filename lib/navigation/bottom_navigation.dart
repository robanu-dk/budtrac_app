import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../pages/profile.dart';
import '../pages/home.dart';
import '../pages/history.dart';

class BottomNavigation extends StatelessWidget {
  int currentIndex;

  BottomNavigation(this.currentIndex);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
        onTap: (value) {
          switch (value) {
            case 0:
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Homepage()));
              break;
            case 1:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => HistoryPage()));
              break;
            case 2:
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => ProfilePage()));
              break;
          }
        },
        height: 60.0,
        animationCurve: Curves.linear,
        buttonBackgroundColor: Colors.grey[200],
        backgroundColor: Colors.pink.shade800,
        index: this.currentIndex,
        items: [
          NavigationIcon(Icons.home, "Home"),
          NavigationIcon(Icons.history, "History"),
          NavigationIcon(Icons.person, "Profile"),
        ]);
  }
}

class NavigationIcon extends StatelessWidget {
  IconData icon;
  String label;
  NavigationIcon(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          this.icon,
          size: 30,
        ),
        Text(
          this.label,
          style: TextStyle(fontSize: 16),
        )
      ],
    );
  }
}
