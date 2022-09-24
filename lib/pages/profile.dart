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
              onPressed: () => null,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage("images/profile.png"),
                    radius: 12,
                  ),
                  Text(
                    "Profile",
                    style: TextStyle(color: Colors.pink[800]),
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
