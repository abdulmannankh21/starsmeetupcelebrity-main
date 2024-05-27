import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../LocalStorage/shared_preferences.dart';
import '../Utilities/app_colors.dart';
import '../models/user_model.dart';

class UserService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  Future<void> updateFCMToken(String userId, String? fcmToken) async {
    try {
      await _firestore.collection('celebrities').doc(userId).update({
        'fcmToken': fcmToken,
      });
    } catch (e) {
      // Handle error
      print('Error updating FCM token: $e');
    }
  }

  Future<UserModel?> getUser(String docId) async {
    try {
      final DocumentSnapshot documentSnapshot = await _firestore
          .collection('celebrities')
          .doc(docId.toLowerCase())
          .get();

      if (documentSnapshot.exists) {
        final userData = documentSnapshot.data() as Map<String, dynamic>;
        return UserModel.fromJson(userData);
      } else {
        if (kDebugMode) {
          print('User with document ID $docId does not exist.');
        }
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error retrieving user data: $e');
      }
      return null;
    }
  }

  Future<void> updateAboutMe(String userId, String aboutMe) async {
    try {
      await _firestore.collection('celebrities').doc(userId).update({
        'bio': aboutMe,
      });

      EasyLoading.showSuccess("About Me updated successfully!");

      UserModel? user = await UserService()
          .getUser(MyPreferences.instance.user!.userID.toString());
      if (user != null) {
        MyPreferences.instance.setUser(user: user);
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: redColor,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating user data: $e');
      }
    }
  }

  Future<void> updateSupportYourStar(String userId, bool supported) async {
    try {
      await _firestore.collection('celebrities').doc(userId).update({
        'supportYourStar': supported,
      });

      EasyLoading.showSuccess("Support Star Updated Successfully!");

      UserModel? user = await UserService()
          .getUser(MyPreferences.instance.user!.userID.toString());
      if (user != null) {
        MyPreferences.instance.setUser(user: user);
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: redColor,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error updating user data: $e');
      }
    }
  }

  Future<String?> uploadProfilePicture(String userId, XFile imageFile) async {
    try {
      final Reference storageRef =
          _storage.ref().child('profile_pictures/$userId.jpg');
      await storageRef.putFile(File(imageFile.path));

      final String downloadUrl = await storageRef.getDownloadURL();
      // Update the user's profile picture URL in Firestore

      await _firestore.collection('celebrities').doc(userId).update({
        'profilePicture': downloadUrl,
      });

      EasyLoading.showSuccess("Picture updated successfully!");

      UserModel? user = await UserService().getUser(
          MyPreferences.instance.user!.userID!.toLowerCase().toString());
      if (user != null) {
        MyPreferences.instance.setUser(user: user);
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: redColor,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      return downloadUrl;
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading profile picture: $e');
      }
      return null;
    }
  }

  Future<String?> uploadBackgroundPicture(
      String userId, XFile imageFile) async {
    try {
      final Reference storageRef =
          _storage.ref().child('background_pictures/$userId.jpg');
      await storageRef.putFile(File(imageFile.path));
      final String downloadUrl = await storageRef.getDownloadURL();
      // Update the user's profile picture URL in Firestore
      await _firestore.collection('celebrities').doc(userId).update({
        'backgroundPicture': downloadUrl,
      });

      EasyLoading.showSuccess("Picture updated successfully!");

      UserModel? user = await UserService().getUser(
          MyPreferences.instance.user!.userID!.toLowerCase().toString());
      if (user != null) {
        MyPreferences.instance.setUser(user: user);
      } else {
        Fluttertoast.showToast(
            msg: "Something went wrong!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 2,
            backgroundColor: redColor,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      return downloadUrl;
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading profile picture: $e');
      }
      return null;
    }
  }
}
