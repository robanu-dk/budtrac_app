import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:country_icons/country_icons.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:list_picker/list_picker.dart';
import 'package:moneytracker/pages/home.dart';

class InputIncomePage extends StatefulWidget {
  InputIncomePage({Key? key}) : super(key: key);

  @override
  State<InputIncomePage> createState() => _InputIncomePageState();
}

class _InputIncomePageState extends State<InputIncomePage> {
  Map<String, dynamic> data = {"nominal": 0};
  List<Map<String, dynamic>> category = [
    {"name": "Salary", "image": "images/salary.png"},
    {"name": "Business", "image": "images/business.png"},
    {"name": "Extra Income", "image": "images/extra income.png"},
    {"name": "Work", "image": "images/work.png"},
    {"name": "Loan", "image": "images/loan.png"},
    {"name": "Gifts", "image": "images/gifts.png"},
    {"name": "Parent's Inheritance", "image": "images/inheritance.png"},
    {"name": "Insurance", "image": "images/insurance.png"},
    {"name": "Other", "image": "images/other.png"},
  ];
  Map<String, dynamic> chosen_category = {};
  String currencyCode = "IDR";
  String currencySymbol = "Rp";
  String countryFlagCode = "id";
  final listPickerField = ListPickerField(
    label: "Source of Income",
    items: const ["Salary", "Debt", "Transfer"],
  );
  String purchase = "Transfer";
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.home),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Input Income",
          style: TextStyle(fontSize: 24),
        ),
        backgroundColor: Colors.pink[800],
      ),
      body: ListView(children: [
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
                                    (currency.code[0] + currency.code[1])
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
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.account_balance_wallet_rounded,
                      size: 28,
                    ),
                    Text(' Wallet'),
                  ],
                ),
                Row(
                  children: [
                    Text(purchase),
                    Icon(
                      Icons.arrow_drop_down,
                      size: 28,
                    )
                  ],
                )
              ],
            ),
            onPressed: () {
              showPickerDialog(
                      context: context,
                      label: listPickerField.label,
                      items: listPickerField.items)
                  .then(
                (value) {
                  setState(() {
                    purchase = value.toString();
                  });
                },
              );
            },
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
              showDialog(
                context: context,
                builder: ((context) {
                  return Dialog(
                    insetPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: GridView.count(
                        crossAxisCount: 4,
                        children: category
                            .map((data) => Card(
                                  shape: RoundedRectangleBorder(
                                    side:
                                        BorderSide(color: Colors.grey.shade300),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(2)),
                                  ),
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    child: IconButton(
                                      splashRadius:
                                          MediaQuery.of(context).orientation ==
                                                  Orientation.landscape
                                              ? 350
                                              : 60,
                                      onPressed: () {
                                        setState(() {
                                          chosen_category = data;
                                        });
                                        Navigator.pop(context);
                                      },
                                      icon: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            data["image"],
                                            height: 35,
                                          ),
                                          Text(
                                            data["name"],
                                            overflow: TextOverflow.ellipsis,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  );
                }),
              );
            },
            icon: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.category,
                      size: 28,
                    ),
                    Text(" Category"),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    children: [
                      if (chosen_category.isNotEmpty)
                        CircleAvatar(
                            backgroundColor: Colors.grey[300],
                            child: Image.asset(
                              chosen_category["image"],
                              width: 30,
                            )),
                      if (chosen_category.isNotEmpty)
                        Text(" ${chosen_category["name"]}"),
                      if (chosen_category.isEmpty) const Text("Choose")
                    ],
                  ),
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
                initialDate: date,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              ).then((value) {
                if (value != null) {
                  setState(() {
                    date = value;
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
                    Text(" Date"),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 7.5),
                  child: Text("${DateFormat.yMMMMd("en_us").format(date)}"),
                )
              ],
            ),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.grey.shade300),
              borderRadius: BorderRadius.all(Radius.circular(2))),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Icon(
                    Icons.note_add,
                    size: 28,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.86,
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      label: Text("Note"),
                    ),
                    maxLines: 5,
                    minLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.all(Radius.circular(2)),
          ),
          child: IconButton(
            iconSize: 50,
            splashRadius:
                MediaQuery.of(context).orientation == Orientation.landscape
                    ? 350
                    : 210,
            onPressed: () {},
            icon: Row(
              children: [
                Icon(
                  Icons.photo,
                  size: 28,
                ),
                Text(" Upload a Image"),
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
      ]),
    );
  }
}
