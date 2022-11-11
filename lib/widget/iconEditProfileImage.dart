import 'package:flutter/material.dart';

class IconEditProfileImage extends StatelessWidget {
  const IconEditProfileImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomRight,
      child: CircleAvatar(
        radius: 15,
        backgroundColor: Colors.pink[800],
        child: Icon(
          Icons.edit,
          color: Colors.white,
          size: 15,
        ),
      ),
    );
  }
}
