import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/notification_Model.dart';

class NotificationController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future uploadNotification(NotificationModel notification) async {
    try {
      await _firestore.collection('notification').add(notification.toJson());
    } catch (e) {
      print('Error uploading notification: $e');
    }
  }

  Future<List<NotificationModel>> getNotificationByUserId(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('notification')
          .where('celebrityId', isEqualTo: userId)
          .get();
      log("i am here: ${querySnapshot.docs.length}");
      return querySnapshot.docs
          .map((doc) => NotificationModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Error getting appointments by user ID: $e');
      // Handle error accordingly
      return [];
    }
  }
}
