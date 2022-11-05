import 'package:flutter/material.dart';
import '../navigation/bottom_navigation.dart';
import '../pages/income.dart';
import '../pages/expense.dart';
import '../pages/limit.dart';
import '../pages/target.dart';

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

class ModalInput extends StatelessWidget {
  const ModalInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(50))),
      child: Container(
        width: MediaQuery.of(context).orientation == Orientation.portrait
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).orientation == Orientation.portrait
            ? MediaQuery.of(context).size.height * 0.5
            : MediaQuery.of(context).size.height,
        child: MediaQuery.of(context).orientation == Orientation.portrait
            ? MenuIfPotrait()
            : MenuIfLandscape(),
      ),
    );
  }
}

class MenuIfLandscape extends StatelessWidget {
  const MenuIfLandscape({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 15),
          child: Center(
            child: Text(
              'Add Data',
              style: TextStyle(
                  fontFamily: "DoppioOne",
                  fontSize: 28,
                  fontWeight: FontWeight.w400,
                  color: Colors.pink[800]),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InputMenu(Icons.money, "Income", InputIncomePage()),
            InputMenu(Icons.money_off, "Expense", InputExpensePage()),
          ],
        ),
        Padding(padding: EdgeInsets.only(top: 5)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InputMenu(Icons.savings, "Set Target", SetTargetPage()),
            InputMenu(Icons.shopping_bag, "Set Limit", SetLimitsPage()),
          ],
        )
      ],
    );
  }
}

class MenuIfPotrait extends StatelessWidget {
  const MenuIfPotrait({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Add Data',
          style: TextStyle(
              fontFamily: "DoppioOne",
              fontSize: 28,
              fontWeight: FontWeight.w400,
              color: Colors.pink[800]),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InputMenu(Icons.money, "Income", InputIncomePage()),
            InputMenu(Icons.money_off, "Expense", InputExpensePage()),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InputMenu(Icons.savings, "Set Target", SetTargetPage()),
            InputMenu(Icons.shopping_bag, "Set Limit", SetLimitsPage()),
          ],
        )
      ],
    );
  }
}

class InputMenu extends StatelessWidget {
  IconData icon;
  String label;
  Widget destination;
  InputMenu(this.icon, this.label, this.destination);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey.shade300),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Container(
        width: 120,
        height: 120,
        child: IconButton(
          splashRadius: 75,
          onPressed: () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => this.destination)),
          icon: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(
              this.icon,
              size: 50,
              color: Colors.pink[800],
            ),
            Text(
              this.label,
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "DoppioOne",
                  fontWeight: FontWeight.w400,
                  color: Colors.pink[800]),
            )
          ]),
        ),
      ),
    );
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
