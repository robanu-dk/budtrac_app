import 'package:flutter/material.dart';

class DetailHistory extends StatelessWidget {
  Map<String, dynamic> data;
  String category_image;

  DetailHistory(this.data, this.category_image);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Detail Information'),
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close),
        )
      ]),
      content: Container(
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        child: ListView(
          children: [Text("Category")],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          color: Colors.pink[800],
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.7,
            child: IconButton(
              splashRadius: MediaQuery.of(context).size.width * 0.33,
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Text(
                "Done",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.w200),
              ),
            ),
          ),
        )
      ],
    );
  }
}
