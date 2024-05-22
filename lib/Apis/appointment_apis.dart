import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/appointment_model.dart';

class AppointmentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Stream<List<AppointmentModel>> getTodayAppointmentsByCelebrityIdStream(
      String celebrityId) async* {
    try {
      DateTime now = DateTime.now();
      DateTime dateWithoutTime =
          DateTime(now.year, now.month, now.day, 0, 0, 0, 0, 0);

      // Fetch appointments for the current day
      Stream<QuerySnapshot<Map<String, dynamic>>> stream = _firestore
          .collection('appointments')
          .where('celebrityId', isEqualTo: celebrityId)
          .where('status', isEqualTo: 'active')
          .where('selectedDate',
              isEqualTo: "${dateWithoutTime.toIso8601String()}")
          .snapshots();

      await for (QuerySnapshot<Map<String, dynamic>> querySnapshot in stream) {
        List<AppointmentModel> celebrityAppointments = querySnapshot.docs
            .map((doc) => AppointmentModel.fromJson(
                doc.data(), doc.id)) // Pass document ID
            .toList();

        // Sort appointments by meeting start time (closest meeting first)
        celebrityAppointments.sort((a, b) {
          // Parse meeting start times as DateTime objects
          DateTime? startTimeA = a.startTime;
          DateTime? startTimeB = b.startTime;

          // Handle nullable DateTime objects
          if (startTimeA == null && startTimeB == null) {
            return 0;
          } else if (startTimeA == null) {
            return 1; // Place appointments with null startTime after others
          } else if (startTimeB == null) {
            return -1; // Place appointments with null startTime before others
          }

          // Compare meeting start times
          return startTimeA.compareTo(startTimeB);
        });

        yield celebrityAppointments;
      }
    } catch (e) {
      print("Error fetching appointments: $e");
      yield []; // Return an empty list in case of error
    }
  }

  Stream<List<AppointmentModel>> getAllAppointmentsByCelebrityIdStream(
      String celebrityId) async* {
    try {
      // Fetch appointments for the current day and later
      print("ID $celebrityId");
      Stream<QuerySnapshot<Map<String, dynamic>>> stream = _firestore
          .collection('appointments')
          .where('celebrityId', isEqualTo: celebrityId)
          .where('status', isEqualTo: 'active')
          // .where('selectedDate', isGreaterThanOrEqualTo: DateTime.now())
          .snapshots();

      await for (QuerySnapshot<Map<String, dynamic>> querySnapshot in stream) {
        List<AppointmentModel> celebrityAppointments = querySnapshot.docs
            .map((doc) => AppointmentModel.fromJson(
                doc.data(), doc.id)) // Pass document ID
            .toList();
        print(celebrityAppointments);
        // Sort appointments by selected date and time
        celebrityAppointments.sort((a, b) {
          // Parse selected dates as DateTime objects
          DateTime? selectedDateA = a.selectedDate;
          DateTime? selectedDateB = b.selectedDate;

          // Handle nullable DateTime objects
          if (selectedDateA == null && selectedDateB == null) {
            return 0;
          } else if (selectedDateA == null) {
            return 1; // Place appointments with null selectedDate after others
          } else if (selectedDateB == null) {
            return -1; // Place appointments with null selectedDate before others
          }

          // Compare selected dates
          int dateComparison = selectedDateA.compareTo(selectedDateB);
          if (dateComparison != 0) {
            return dateComparison; // Return if dates are not equal
          }

          // If dates are equal, compare meeting start times
          DateTime? startTimeA = a.startTime;
          DateTime? startTimeB = b.startTime;

          // Handle nullable DateTime objects
          if (startTimeA == null && startTimeB == null) {
            return 0;
          } else if (startTimeA == null) {
            return 1; // Place appointments with null startTime after others
          } else if (startTimeB == null) {
            return -1; // Place appointments with null startTime before others
          }

          // Compare meeting start times
          return startTimeA.compareTo(startTimeB);
        });

        yield celebrityAppointments;
      }
    } catch (e) {
      print("Error fetching appointments: $e");
      yield []; // Return an empty list in case of error
    }
  }

  Future<List<AppointmentModel>> getAppointmentsByCelebrityId(
      String celebrityId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('appointments')
          .where('celebrityId', isEqualTo: celebrityId)
          .where('status', isEqualTo: 'active')
          .get();

      return querySnapshot.docs
          .map((doc) =>
              AppointmentModel.fromJson(doc.data(), doc.id)) // Pass document ID
          .toList();
    } catch (e) {
      // Handle error accordingly
      return [];
    }
  }

  Future<void> cancelAppointments(String docId) async {
    try {
      await _firestore.collection('appointments').doc(docId).update({
        'status': 'cancelled',
      });

      print('Appointment cancelled successfully $docId');
    } catch (e) {
      print('Error cancelling appointment by document ID and celebrity ID: $e');
      // Handle error accordingly
    }
  }

  Future<List<AppointmentModel>> getCancelledAppointmentsByCelebrityId(
      String celebrityId) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection('appointments')
          .where('celebrityId', isEqualTo: celebrityId)
          .where("status", isEqualTo: "cancelled")
          .get();

      return querySnapshot.docs
          .map((doc) => AppointmentModel.fromJson(doc.data(), doc.id))
          .toList();
    } catch (e) {
      print('Error getting appointments by user ID: $e');
      // Handle error accordingly
      return [];
    }
  }
}
