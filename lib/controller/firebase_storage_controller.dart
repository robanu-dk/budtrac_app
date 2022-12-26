import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../provider/user_provider.dart';

class FirebaseStorageController extends GetxController {
  FirebaseStorage _storage = FirebaseStorage.instance;

  Future selectImageFromCamera() async {
    XFile? cameraFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (cameraFile != null) {
      return File(cameraFile.path);
    }
    return null;
  }

  Future selectImageFromGallery() async {
    XFile? cameraFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (cameraFile != null) {
      return File(cameraFile.path);
    }
    return null;
  }

// Upload image
  Future<String> uploadImage(String imageFor, String userId, File file) async {
    try {
      var url;

      String extention = file.path.split('.').last;

      var index = await _storage
          .ref('$userId/$imageFor')
          .listAll()
          .then((value) => value.items.length);

      String namaFile = '${userId}_$imageFor$index.$extention';
      String ref = '$userId/$imageFor/$namaFile';

      var storageAction = _storage.ref(ref);
      await storageAction.putFile(file);

      await storageAction.getDownloadURL().then((value) => url = value);

      return '$ref+$url';
    } catch (error) {
      throw error;
    }
  }

// Delete image
  Future<void> deleteImage(String ref) async {
    await _storage.ref(ref).delete();
  }

// Update Profile Photo
  Future<String> updateProfilePhoto({
    required String imageFor,
    required String userId,
    required String ref,
    required File file,
  }) async {
    try {
      var _url;

      String extention = file.path.split(".").last;
      String fileName = '$userId.$extention';
      String newRef = '$userId/$imageFor/$fileName';

      if (ref != "profile.png") {
        await deleteImage(ref);
      }

      await _storage.ref(newRef).putFile(file);

      await _storage.ref(newRef).getDownloadURL().then((url) => _url = url);

      return '$newRef+$_url';
    } catch (error) {
      throw error;
    }
  }

  Future<String> updateAttachmentHistory(String ref, File file) async {
    if (ref != "") {
      await deleteImage(ref);
    }

    late String mediaUrl;
    String newRef = "${ref.split('.').first}.${file.path.split('.').last}";

    await _storage.ref(newRef).putFile(file);

    await _storage
        .ref(newRef)
        .getDownloadURL()
        .then((value) => mediaUrl = value);

    return "$newRef+$mediaUrl";
  }
}
