import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:country_icons/country_icons.dart';
import 'package:intl/intl.dart';
import 'package:list_picker/list_picker.dart';
import 'package:moneytracker/pages/home.dart';

class SetTargetPage extends StatefulWidget {
  const SetTargetPage({Key? key}) : super(key: key);

  @override
  State<SetTargetPage> createState() => _SetTargetPageState();
}

class _SetTargetPageState extends State<SetTargetPage> {
  DateTime timeStart = DateTime.now();
  DateTime timeEnd = DateTime.now();
  String currencyCode = "IDR";
  String currencySymbol = "Rp";
  String countryFlagCode = "id";
  String interval = "Month";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink[800],
        title: Text(
          "Set Target",
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        children: [
          Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.all(Radius.circular(2))),
            child: Container(
              padding: EdgeInsets.only(left: 10),
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.monetization_on),
                      Text(' Nominal'),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 22,
                        child: TextField(
                          autofocus: true,
                          autocorrect: false,
                          decoration: InputDecoration(
                            prefixText: currencySymbol,
                            hintStyle:
                                TextStyle(color: Colors.grey, fontSize: 14),
                          ),
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.end,
                          keyboardType: TextInputType.number,
                          onSubmitted: (value) {
                            setState(() {}); // Don't forget to give code
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).orientation ==
                                Orientation.portrait
                            ? MediaQuery.of(context).size.width * 0.26
                            : MediaQuery.of(context).size.width * 0.13,
                        child: IconButton(
                          onPressed: () {
                            showCurrencyPicker(
                              context: context,
                              showFlag: true,
                              showCurrencyName: true,
                              showCurrencyCode: true,
                              onSelect: (Currency currency) {
                                setState(() {
                                  currencyCode = currency.code;
                                  currencySymbol = currency.symbol;
                                  countryFlagCode =
                                      (currencyCode[0] + currencyCode[1])
                                          .toLowerCase();
                                });
                              },
                            );
                          },
                          icon: Row(children: [
                            Container(
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.grey.shade300)),
                              child: Image.asset(
                                'icons/flags/png/${countryFlagCode}.png',
                                package: 'country_icons',
                                width: 20,
                              ),
                            ),
                            Text(' ${currencyCode}'),
                            Icon(Icons.arrow_drop_down)
                          ]),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.all(Radius.circular(2))),
            child: IconButton(
              splashRadius:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? 350
                      : 210,
              iconSize: 50,
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: timeStart,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      timeStart = value;
                    });
                  }
                });
              },
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        size: 28,
                      ),
                      Text(" Date Start"),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 7.5),
                    child:
                        Text("${DateFormat.yMMMMd("en_us").format(timeStart)}"),
                  )
                ],
              ),
            ),
          ),
          Card(
            shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey.shade300),
                borderRadius: BorderRadius.all(Radius.circular(2))),
            child: IconButton(
              splashRadius:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? 350
                      : 210,
              iconSize: 50,
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: timeEnd,
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                ).then((value) {
                  if (value != null) {
                    setState(() {
                      timeEnd = value;
                    });
                  }
                });
              },
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        size: 28,
                      ),
                      Text(" Date End"),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 7.5),
                    child:
                        Text("${DateFormat.yMMMMd("en_us").format(timeEnd)}"),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 50, right: 50),
            child: Card(
              color: Colors.pink[800],
              shadowColor: Colors.white,
              shape: RoundedRectangleBorder(
                  side: BorderSide(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: IconButton(
                splashRadius: 160,
                iconSize: 28,
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homepage(),
                      ));
                },
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
