import 'package:flutter/material.dart';

import '../navigation/bottom_navigation.dart';
import '../widget/modalMenu.dart';
import '../widget/moneyValue.dart';
import '../widget/cardTotalIncomeExpense.dart';
import '../widget/cardWelcome.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool income = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.pink[800],
          title: Text(
            "BudTrac",
            style: TextStyle(fontFamily: 'EBGaramond', fontSize: 26),
          ),
        ),
        body: ListView(children: [
          CardWelcome('User'),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Card(
                  color: income ? Colors.pink[800] : Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      side: BorderSide(color: Colors.grey.shade300)),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          income = true;
                        });
                      },
                      icon: Text(
                        'Income',
                        style: TextStyle(
                            fontFamily: 'DoppioOne',
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: income ? Colors.white : Colors.pink[800]),
                      ),
                      splashRadius: MediaQuery.of(context).size.width * 0.22,
                    ),
                  ),
                ),
                Card(
                  color: income ? Colors.white : Colors.pink[800],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      side: BorderSide(color: Colors.grey.shade300)),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          income = false;
                        });
                      },
                      icon: Text(
                        'Expense',
                        style: TextStyle(
                            fontFamily: 'DoppioOne',
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                            color: income ? Colors.pink[800] : Colors.white),
                      ),
                      splashRadius: MediaQuery.of(context).size.width * 0.22,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, left: 10, right: 10),
            child:
                CardTotalIncomeExpense("Rp 2.000.000", "Rp 1.000.000", income),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  side: BorderSide(color: Colors.grey.shade300)),
              color: Colors.grey[100],
              child: Container(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MoneyValue((income ? 'Rp 200.000' : 'Rp 100.000'),
                            'Today\'s ' + (income ? 'funds' : 'expenses')),
                        MoneyValue((income ? 'Rp 60.000' : 'Rp 30.000'),
                            'Average daily ' + (income ? 'funds' : 'expenses')),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10, left: 80, right: 80),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  side: BorderSide(color: Colors.grey.shade300)),
              color: Colors.grey[100],
              child: Container(
                padding: EdgeInsets.only(right: 10, left: 10),
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      income ? "Target" : "Limit",
                      style: TextStyle(
                          fontFamily: "DoppioOne",
                          fontSize: 22,
                          fontWeight: FontWeight.w400,
                          color: Colors.pink[800]),
                    ),
                    Text(
                      income
                          ? "Rp 2.000.000 / Rp 2.500.000"
                          : "Rp 1.000.000 / Rp 1.500.000",
                      style: TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: 16,
                          fontWeight: FontWeight.w400),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 8, right: 10),
          child: FloatingActionButton(
            backgroundColor: Colors.pink[800],
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return ModalInput();
                },
              );
            },
            child: Icon(Icons.add),
          ),
        ),
        bottomNavigationBar: BottomNavigation(0));
  }
}
