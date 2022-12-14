import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/money_provider.dart';
import '../provider/user_provider.dart';
import '../pages/home.dart';
import '../controller/firebase_storage_controller.dart';

class SaveData extends StatelessWidget {
  final String nominal, purchase, note;
  final Map<String, dynamic> chosen_category;
  final DateTime date;
  final bool incomeStat;
  final file;

  FirebaseStorageController controller = FirebaseStorageController();

  SaveData({
    Key? key,
    required this.nominal,
    required this.purchase,
    required this.chosen_category,
    required this.date,
    required this.note,
    required this.file,
    required this.incomeStat,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final income = Provider.of<Money>(context, listen: false);
    final user = Provider.of<User>(context, listen: false);

    void postDataMoney({
      required String nominal,
      required String purchase,
      required Map<String, dynamic> chosen_category,
      required String date,
      required String note,
      String imageName = "",
      String imageUrl = "",
      required bool incomeStat,
    }) {
      income.postData(
        nominal: nominal,
        wallet: purchase,
        category: chosen_category['name'],
        date: date.toString(),
        note: note,
        mediaName: imageName,
        mediaUrl: imageUrl,
        income: incomeStat,
      );
    }

    return AlertDialog(
      title: Text("Are you sure to save the data?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('No')),
        TextButton(
          onPressed: () {
            if (file == "") {
              postDataMoney(
                nominal: nominal,
                purchase: purchase,
                chosen_category: chosen_category,
                date: date.toString(),
                note: note,
                incomeStat: incomeStat,
              );
            } else {
              controller.uploadImage("Money", user.uid, file).then((value) {
                postDataMoney(
                  nominal: nominal,
                  purchase: purchase,
                  chosen_category: chosen_category,
                  date: date.toString(),
                  note: note,
                  imageName: value.split("+").first,
                  imageUrl: value.split("+").last,
                  incomeStat: incomeStat,
                );
              });
            }

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Save Successfull!!"),
                duration: Duration(seconds: 2),
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Homepage(),
              ),
            );
          },
          child: Text('Yes'),
        )
      ],
    );
  }
}
