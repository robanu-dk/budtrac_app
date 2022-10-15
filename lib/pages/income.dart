import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:country_icons/country_icons.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:list_picker/list_picker.dart';

class InputIncomePage extends StatefulWidget {
  InputIncomePage({Key? key}) : super(key: key);

  @override
  State<InputIncomePage> createState() => _InputIncomePageState();
}

class _InputIncomePageState extends State<InputIncomePage> {
  Map<String, dynamic> data = {"nominal": 0};
  String currencyCode = "IDR";
  String countryFlagCode = "id";
  final listPickerField = ListPickerField(
    label: "Purchase Method",
    items: const ["cash", "credit", "transfer"],
  );
  String purchase = "cash";

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
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.end,
                        keyboardType: TextInputType.number,
                        onSubmitted: (value) {
                          setState(() {
                            data['nominal'] = value;
                          });
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
                  items: listPickerField.items);
              print(listPickerField.value);
              print('dfdf');
            },
          ),
        ),
      ]),
    );
  }
}
