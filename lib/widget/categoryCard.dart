import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.chosen_category,
  }) : super(key: key);

  final Map<String, dynamic> chosen_category;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(
              Icons.category,
              size: 28,
            ),
            Text(" Category"),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(
            children: [
              if (chosen_category.isNotEmpty)
                CircleAvatar(
                    backgroundColor: Colors.grey[300],
                    child: Image.asset(
                      chosen_category["image"],
                      width: 30,
                    )),
              if (chosen_category.isNotEmpty)
                Text(" ${chosen_category["name"]}"),
              if (chosen_category.isEmpty) const Text("Choose")
            ],
          ),
        )
      ],
    );
  }
}
