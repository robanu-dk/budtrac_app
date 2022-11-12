import 'package:flutter/material.dart';

class TombolActionProfilePage extends StatelessWidget {
  IconData icon;
  String title;
  TextStyle style_title;
  Color icon_color;

  TombolActionProfilePage({
    required this.icon,
    required this.title,
    required this.style_title,
    required this.icon_color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          icon,
          color: icon_color,
        ),
        Text(
          title,
          style: style_title,
        )
      ],
    );
  }
}
