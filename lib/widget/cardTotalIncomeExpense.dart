import 'package:flutter/material.dart';

class CardTotalIncomeExpense extends StatelessWidget {
  bool income;
  String incomeTotal, ExpenseTotal;
  CardTotalIncomeExpense(this.incomeTotal, this.ExpenseTotal, this.income);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      color: Colors.pink[700],
      child: Container(
        height: 150,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              income ? this.incomeTotal : this.ExpenseTotal,
              style: TextStyle(
                fontFamily: "DoppioOne",
                fontSize: 35,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              "This monthly total " + (this.income ? "funds" : "expenses"),
              style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
