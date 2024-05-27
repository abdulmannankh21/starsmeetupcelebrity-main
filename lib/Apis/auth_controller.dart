import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:starsmeetupcelebrity/Apis/user_apis.dart';

import '../LocalStorage/shared_preferences.dart';
import '../Utilities/app_colors.dart';
import '../Utilities/app_routes.dart';
import '../models/user_model.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  get user => _auth.currentUser;

  Future signUp({String? email, String? password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);
      return null;
    } on FirebaseAuthException catch (e) {
      EasyLoading.showError(e.message.toString());
      return e.message;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }

      return e.message;
    } on SocketException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }

      return e.message;
    }
  }

  Future changePassword(
      String email, String currentPassword, String newPassword) async {
    try {
      final AuthCredential credential = EmailAuthProvider.credential(
        email: email,
        password: currentPassword,
      );

      final User user = FirebaseAuth.instance.currentUser!;
      await user.reauthenticateWithCredential(credential).then((value) async {
        await user.updatePassword(newPassword);

        await FirebaseFirestore.instance
            .collection('celebrities')
            .doc(email)
            .update({
          'Password': newPassword,
        });

        UserModel? user2 = await UserService()
            .getUser(MyPreferences.instance.user!.userID.toString());
        if (user2 != null) {
          MyPreferences.instance.setUser(user: user2);
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

        return null;
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == "internal-error" || e.code == "wrong-password") {
        EasyLoading.showError("Incorrect Password!");
      } else {
        EasyLoading.showError(e.message.toString());
      }
      return 0;
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return 0;
    } on SocketException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return 0;
    }
  }

  Future signIn({String? email, String? password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.message!.contains("INVALID_LOGIN_CREDENTIALS")) {
        EasyLoading.showError("Invalid Email or Password!");
      } else {
        EasyLoading.showError(e.message.toString());
      }

      return e.message;
    } on PlatformException catch (e) {
      EasyLoading.showError(e.message.toString());

      return e.message;
    } on SocketException catch (e) {
      EasyLoading.showError(e.message.toString());

      return e.message;
    }
  }

  Future signOut() async {
    await _auth.signOut();
  }

  deleteAccount(context) async {
    try {
      await user.delete();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString("currentUserEmail");

      FirebaseFirestore.instance
          .collection('celebrities')
          .doc(email!.toLowerCase())
          .collection("products")
          .get()
          .then((querySnapshot) {
        for (var document in querySnapshot.docs) {
          document.reference.delete();
        }
      });
      FirebaseFirestore.instance
          .collection('celebrities')
          .doc(email.toLowerCase())
          .collection("sales")
          .get()
          .then((querySnapshot) {
        for (var document in querySnapshot.docs) {
          document.reference.delete();
        }
      });
      FirebaseFirestore.instance
          .collection('celebrities')
          .doc(email.toLowerCase())
          .collection("notifications")
          .get()
          .then((querySnapshot) {
        for (var document in querySnapshot.docs) {
          document.reference.delete();
        }
      });

      FirebaseFirestore.instance
          .collection('celebrities')
          .doc(email.toLowerCase())
          .delete();

      EasyLoading.showSuccess("Account Deleted Successfully");

      Navigator.pushNamedAndRemoveUntil(
          context, loginScreenRoute, (route) => false);
      prefs.clear();
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  late EmailAuth auth;

  Future enterEmailAuth(email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email).then((value) {
        if (kDebugMode) {
          print("Email Sent!");
        }
      });
      return null;
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      EasyLoading.showError(e.message.toString());
      return e.message;
    } on PlatformException catch (e) {
      EasyLoading.showError(e.message.toString());

      if (kDebugMode) {
        print(e.message);
      }
      return e.message;
    } on SocketException catch (e) {
      EasyLoading.showError(e.message.toString());

      if (kDebugMode) {
        print(e.message);
      }
      return e.message;
    }
  }
}
