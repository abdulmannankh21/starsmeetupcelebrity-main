import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/historyModel.dart';

class HistoryController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<HistoryModel>> getAppointmentsByUserIdCurrentMonth(
      String userId) async {
    try {
      int currentYear = DateTime.now().year;
      int currentMonth = DateTime.now().month;
      DateTime startOfMonth = DateTime(currentYear, currentMonth, 1);
      DateTime endOfMonth = DateTime(currentYear, currentMonth + 1, 1)
          .subtract(Duration(days: 1));

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('appointments')
          .where('userId', isEqualTo: userId)
          .where("status", isEqualTo: "active")
          .get();

      List<HistoryModel> appointments = querySnapshot.docs
          .map((doc) => HistoryModel.fromJson(doc.data()))
          .where((appointment) {
        // Parse creationTimestamp string to DateTime object
        DateTime creationTimestamp =
            DateTime.parse(appointment.startTime.toString());
        // Check if creationTimestamp is within the current month
        return creationTimestamp.isAfter(startOfMonth) &&
            creationTimestamp.isBefore(endOfMonth);
      }).toList();

      log("Appointments for user ID $userId for current month: ${appointments.length}");

      // Print data from each document
      appointments.forEach((appointment) {
        print("this is result ${appointment.toJson()}");
      });

      return appointments;
    } catch (e) {
      print('Error getting appointments by user ID: $e');
      // Handle error accordingly
      return [];
    }
  }

  Future<List<HistoryModel>> getAppointmentsByUserIdwithYear(
      String userId) async {
    try {
      int currentYear = DateTime.now().year;
      DateTime startOfYear = DateTime(currentYear, 1, 1);
      DateTime endOfYear =
          DateTime(currentYear + 1, 1, 1).subtract(Duration(days: 1));

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('appointments')
          .where('userId', isEqualTo: userId)
          .where("status", isEqualTo: "active")
          .get();

      List<HistoryModel> appointments = querySnapshot.docs
          .map((doc) => HistoryModel.fromJson(doc.data()))
          .where((appointment) {
        // Parse creationTimestamp string to DateTime object
        DateTime creationTimestamp =
            DateTime.parse(appointment.startTime.toString());
        // Check if creationTimestamp is within the current year
        return creationTimestamp.isAfter(startOfYear) &&
            creationTimestamp.isBefore(endOfYear);
      }).toList();

      log("Appointments for user ID $userId for current year: ${appointments.length}");

      // Print data from each document
      appointments.forEach((appointment) {
        print("this is result ${appointment.toJson()}");
      });

      return appointments;
    } catch (e) {
      print('Error getting appointments by user ID: $e');
      // Handle error accordingly
      return [];
    }
  }

  Future<List<HistoryModel>> getAppointmentsByUserId(String userId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('appointments')
          .where('userId', isEqualTo: userId)
          .where("status", isEqualTo: "active")
          .get();
      log("i am here: ${querySnapshot.docs.length}");

      return querySnapshot.docs
          .map((doc) => HistoryModel.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Error getting appointments by user ID: $e');
      // Handle error accordingly
      return [];
    }
  }

  Future<List<HistoryModel>> getHistoryByUserIdCustomdate(
      String userId, DateTime startDate, DateTime endDate) async {
    log("this is start date: ${startDate}-${endDate}");
    int currentYear = DateTime.now().year;
    DateTime startOfYear =
        DateTime(startDate.year, startDate.month, startDate.day);
    DateTime endOfYear = DateTime(endDate.year, endDate.month, endDate.day);
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('appointments')
          .where('userId', isEqualTo: userId)
          .where("status", isEqualTo: "active")
          .get();
      List<HistoryModel> appointments = querySnapshot.docs
          .map((doc) => HistoryModel.fromJson(doc.data()))
          .where((appointment) {
        // Parse creationTimestamp string to DateTime object
        DateTime creationTimestamp =
            DateTime.parse(appointment.startTime.toString());
        // Check if creationTimestamp is within the current year
        return creationTimestamp.isAfter(startOfYear) &&
            creationTimestamp.isBefore(endOfYear);
      }).toList();

      log("Appointments for user ID $userId for current year: ${appointments.length}");
      // if (appointments.length == 0) {
      //   return [];
      // }
      // Print data from each document
      appointments.forEach((appointment) {
        print("this is result ${appointment.toJson()}");
      });

      return appointments;
    } catch (e) {
      print('Error getting appointments by user ID: $e');
      // Handle error accordingly
      return [];
    }
  }
}
