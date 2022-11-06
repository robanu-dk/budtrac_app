import 'package:flutter/material.dart';

class CardWelcome extends StatelessWidget {
  String name;
  CardWelcome(this.name);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.all(13),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 173, 20, 86),
                  Color.fromARGB(120, 165, 100, 129),
                  Color.fromARGB(0, 160, 149, 154),
                ])),
        height: 120,
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Welcome, " + this.name,
                maxLines: 1,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'DoppioOne',
                    fontWeight: FontWeight.w400,
                    fontSize: 36,
                    shadows: [
                      Shadow(
                          offset: Offset(0, 4),
                          color: Color.fromARGB(103, 0, 0, 0),
                          blurRadius: 4)
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "Have a nice day !",
                style: TextStyle(
                    color: Colors.pink[800],
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    shadows: [
                      Shadow(
                          offset: Offset(0, 4),
                          color: Color.fromARGB(103, 0, 0, 0),
                          blurRadius: 4)
                    ]),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
