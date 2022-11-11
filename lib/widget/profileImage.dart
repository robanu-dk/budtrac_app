import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  String image;
  ProfileImage({
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: Image.asset(this.image),
    );
  }
}
