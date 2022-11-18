import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:country_icons/country_icons.dart';
import 'package:currency_picker/currency_picker.dart';

import '../provider/target_limit_provider.dart';

class CardInputNominal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final targetAndLimit = Provider.of<TargetLimit>(context, listen: false);

    return Card(
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
            Consumer<TargetLimit>(
              builder: (context, value, child) => Row(
                children: [
                  Container(
                    width: 100,
                    height: 22,
                    child: TextField(
                      onChanged: (value) {
                        targetAndLimit.setNominal(value);
                      },
                      autofocus: true,
                      autocorrect: false,
                      decoration: InputDecoration(
                        prefixText: targetAndLimit.getCurrencyCode,
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.end,
                      keyboardType: TextInputType.number,
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
                            print(currency.code);
                            targetAndLimit.setCurrency(
                              currencyCode: currency.code,
                              currencySymbol: currency.symbol,
                              countryFlagCode:
                                  (currency.code[0] + currency.code[1])
                                      .toLowerCase(),
                            );
                          },
                        );
                      },
                      icon: Row(children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey.shade300)),
                          child: Image.asset(
                            'icons/flags/png/${targetAndLimit.getCountryFlagCode}.png',
                            package: 'country_icons',
                            width: 20,
                          ),
                        ),
                        Text(' ${targetAndLimit.getCurrencyCode}'),
                        Icon(Icons.arrow_drop_down)
                      ]),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
