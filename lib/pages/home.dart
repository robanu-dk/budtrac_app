import 'package:flutter/material.dart';
import '../navigation/bottom_navigation.dart';

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: income ? Colors.pink[800] : Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
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
                Padding(padding: EdgeInsets.only(left: 5)),
                Card(
                  color: income ? Colors.white : Colors.pink[800],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.45,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          income = false;
                        });
                      },
                      icon: Text(
                        'Outcome',
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
                CardTotalIncomeOutcome("Rp 2.000.000", "Rp 1.000.000", income),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  side: BorderSide(color: Colors.grey.shade300)),
              color: Colors.grey[100],
              child: Container(
                height: 115,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MoneyValue((income ? 'Rp 200.000' : 'Rp 100.000'),
                            'Today\'s ' + (income ? 'funds' : 'expenses')),
                        Padding(padding: EdgeInsets.only(right: 20)),
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
                height: 115,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      income ? "Target" : "Limit",
                      style: TextStyle(
                          fontFamily: "DoppioOne",
                          fontSize: 24,
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
            onPressed: () {},
            child: Icon(Icons.add),
          ),
        ),
        bottomNavigationBar: BottomNavigation(0));
  }
}

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
                fontSize: 24,
                color: Colors.pink[800],
                fontWeight: FontWeight.w400),
            maxLines: 2,
          ),
          Text(
            this.keterangan,
            style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 20,
                fontWeight: FontWeight.w400),
            maxLines: 2,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}

class CardTotalIncomeOutcome extends StatelessWidget {
  bool income;
  String incomeTotal, outcomeTotal;
  CardTotalIncomeOutcome(this.incomeTotal, this.outcomeTotal, this.income);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15))),
      color: Colors.pink[700],
      child: Container(
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              income ? this.incomeTotal : this.outcomeTotal,
              style: TextStyle(
                fontFamily: "DoppioOne",
                fontSize: 40,
                fontWeight: FontWeight.w400,
                color: Colors.white,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            Text(
              "This monthly total " + (this.income ? "funds" : "expenses"),
              style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 20,
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

class CardWelcome extends StatelessWidget {
  String name;
  CardWelcome(this.name);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(
            color: Colors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10))),
      margin: EdgeInsets.all(13),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 173, 20, 86),
                  Color.fromARGB(120, 165, 100, 129),
                  Color.fromARGB(0, 160, 149, 154),
                ])),
        height: 120,
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "Welcome, " + this.name,
                maxLines: 1,
                style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'DoppioOne',
                    fontWeight: FontWeight.w400,
                    fontSize: 36,
                    shadows: [
                      Shadow(
                          offset: Offset(0, 4),
                          color: Color.fromARGB(103, 0, 0, 0),
                          blurRadius: 4)
                    ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "Have a nice day !",
                style: TextStyle(
                    color: Colors.pink[800],
                    fontFamily: 'OpenSans',
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    shadows: [
                      Shadow(
                          offset: Offset(0, 4),
                          color: Color.fromARGB(103, 0, 0, 0),
                          blurRadius: 4)
                    ]),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
