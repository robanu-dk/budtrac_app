import 'package:flutter/material.dart';
import '../pages/target.dart';
import '../pages/limit.dart';
import '../pages/income.dart';
import '../pages/expense.dart';

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
