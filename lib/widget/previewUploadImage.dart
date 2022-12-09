import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './profileImage.dart';
import '../pages/profile.dart';
import '../controller/firebase_storage_controller.dart';
import '../provider/user_provider.dart';

class PreviewUploadImage extends StatelessWidget {
  File file;
  String imageFor, userId;
  PreviewUploadImage({
    required this.file,
    required this.imageFor,
    required this.userId,
  });

  FirebaseStorageController controller = FirebaseStorageController();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: false);

    return AlertDialog(
      title: Text(
        'Preview',
      ),
      content: ProfileImage(
        image: Image.file(file),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            "No",
            style: TextStyle(color: Colors.red),
          ),
        ),
        Consumer<User>(
          builder: (context, value, child) => TextButton(
            onPressed: () {
              controller
                  .updateProfilePhoto(
                      imageFor: imageFor,
                      userId: userId,
                      ref: user.getImage,
                      file: file)
                  .then(
                    (value) => user.updateProfileImage(value),
                  );
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => ProfilePage(),
                ),
              );
            },
            child: Text("Save"),
          ),
        ),
      ],
    );
  }
}
