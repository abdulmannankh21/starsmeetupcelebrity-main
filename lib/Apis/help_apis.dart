import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class HelpService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadHelpRequest(
      String email, String subject, String message) async {
    try {
      await _firestore.collection('helpRequests').add({
        'email': email,
        'subject': subject,
        'message': message,
      });

      EasyLoading.showSuccess("Help Request Submitted successfully!");
    } catch (e) {
      if (kDebugMode) {
        print('Error updating user data: $e');
      }
    }
  }
}
