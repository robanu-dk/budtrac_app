import 'package:flutter/material.dart';

class MoneyValue extends StatelessWidget {
  String value, keterangan;
  MoneyValue(this.value, this.keterangan);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 165,
      child: Column(
        children: [
          Text(
            this.value,
            style: TextStyle(
                fontFamily: "DoppioOne",
                fontSize: 20,
                color: Colors.pink[800],
                fontWeight: FontWeight.w400),
            maxLines: 2,
          ),
          Text(
            this.keterangan,
            style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 16,
                fontWeight: FontWeight.w400),
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
