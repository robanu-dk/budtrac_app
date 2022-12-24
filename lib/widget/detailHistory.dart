import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailHistory extends StatelessWidget {
  Map<String, dynamic> data;
  Map<String, dynamic> iconDataFor = {
    'category': Icon(Icons.category),
    'nominal': Icon(Icons.monetization_on),
    'wallet': Icon(Icons.account_balance_wallet_rounded),
    'date': Icon(Icons.calendar_month),
    'note': Icon(Icons.note),
    'media': Icon(Icons.image),
  };

  String category_image;

  DetailHistory(this.data, this.category_image);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.all(10),
      title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('Detail ${data["income"] ? "Income" : "Expense"}'),
        IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.close),
        )
      ]),
      content: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        width: MediaQuery.of(context).size.width * 1,
        height: MediaQuery.of(context).size.height * 1,
        child: ListView(
          children: [
            rowInformation(context, "category"),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: rowInformation(context, "nominal"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: rowInformation(context, "wallet"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: rowInformation(context, "date"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: rowInformation(context, "note"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0),
              child: data['mediaUrl'] == ''
                  ? Row(
                      children: [
                        iconDataFor['media'],
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Attachment",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Row(
                          children: [
                            iconDataFor['media'],
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                "Attachment",
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Image.network(
                            data['mediaUrl'],
                            width: MediaQuery.of(context).size.width * 1,
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ],
                    ),
            ),
          ],
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
                "Close",
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

  Row rowInformation(BuildContext context, String dataFor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            iconDataFor[dataFor],
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "${dataFor[0].toUpperCase() + dataFor.substring(1)}",
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          ],
        ),
        dataFor == "category"
            ? Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.35,
                      child: Text(
                        '${data[dataFor]}',
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ),
                  CircleAvatar(
                    child: Image.asset(category_image),
                    backgroundColor: Colors.black,
                  )
                ],
              )
            : dataFor == "nominal"
                ? Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                          child: Text(
                            '${data[dataFor]}',
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                      CircleAvatar(
                        child: Text(
                          '${data['currency']}',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        backgroundColor: Color.fromARGB(255, 211, 210, 210),
                      )
                    ],
                  )
                : SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Text(
                      '${dataFor == "date" ? DateFormat.yMMMMd().format(DateTime.parse(data["date"])) : data[dataFor]}',
                      textAlign: TextAlign.end,
                    ),
                  ),
      ],
    );
  }
}
