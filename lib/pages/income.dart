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
                      width: MediaQuery.of(context).size.width * 0.26,
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
            splashRadius: 210,
            iconSize: MediaQuery.of(context).size.height * 0.08,
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
            splashRadius: 210,
            iconSize: MediaQuery.of(context).size.height * 0.08,
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
            iconSize: MediaQuery.of(context).size.height * 0.08,
            splashRadius: 210,
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
