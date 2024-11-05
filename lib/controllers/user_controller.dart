import 'dart:io';
import 'dart:developer' as debug;

import 'package:alcoholic/models/section_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/Utilities/alcoholic.dart';
import 'share_dao_functions.dart';

class UserController extends GetxController {
  static UserController instance = Get.find();

  late Rx<File?> pickedProfileImageFile;
  File? get alcoholicProfileImageFile => pickedProfileImageFile.value;

  void chooseAlcoholicProfileImageFromGallery() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImageFile != null) {
      Get.snackbar('Image Status', 'Image File Successfully Picked.');
    }

    // Share the chosen image file on Getx State Management.
    pickedProfileImageFile = Rx<File?>(File(pickedImageFile!.path));
  }

  void captureAlcoholicProfileImageWithCamera() async {
    final pickedImageFile =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (pickedImageFile != null) {
      Get.snackbar('Image Status', 'Image File Successfully Captured.');
    }

    // Share the chosen image file on Getx State Management.
    pickedProfileImageFile = Rx<File?>(File(pickedImageFile!.path));
  }

  void saveAlcoholic(File alcoholicProfileImage, String phoneNumber,
      SectionName sectionName, String uid, String username) async {
    // Step 1 - create user in the firebase authentication. [Performed On The Screen Calling This Method]
    // Step 2 - save user image in firebase storage.
    // Step 3 - save user data in cloud firestore database.
    try {
      // 'gs://alcoholic-expressions.appspot.com/alcoholics/+27625446322.jpg'
      // 1. Create download URL & save alcoholic image in firebase storage.
      String alcoholicImageURL = await uploadResource(alcoholicProfileImage,
          '/alcoholics/$phoneNumber/profile_images/$phoneNumber');

      Alcoholic alcoholic = Alcoholic(
          phoneNumber: phoneNumber,
          profileImageURL: alcoholicImageURL,
          username: username,
          sectionName: sectionName);

      // 3. Save alcoholic object
      await FirebaseFirestore.instance
          .collection('alcoholics')
          .doc(phoneNumber)
          .set(alcoholic.toJson());
      showProgressBar = false;
    } catch (error) {
      Get.snackbar("Saving Error", "Alcoholic Couldn'\t Be Saved.");
      debug.log(error.toString());
      showProgressBar = false;
    }
  }
}
