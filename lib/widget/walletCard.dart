import 'package:flutter/material.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({
    Key? key,
    required this.purchase,
  }) : super(key: key);

  final String purchase;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
