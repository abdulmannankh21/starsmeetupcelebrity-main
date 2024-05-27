import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:starsmeetupcelebrity/LocalStorage/shared_preferences.dart';
import 'package:starsmeetupcelebrity/models/holiday_mode_model.dart';

class HolidayModeService {
  final CollectionReference holidaysCollection =
      FirebaseFirestore.instance.collection('holidays');

  Future<void> saveHoliday(DateTime startDate, DateTime endDate) async {
    await holidaysCollection.doc(MyPreferences.instance.user!.userID).set(
          HolidayMode(
            startDate: startDate,
            endDate: endDate,
            timestamp: DateTime.now().millisecondsSinceEpoch,
          ).toMap(),
        );
  }

  Future<void> removeHoliday() async {
    await holidaysCollection.doc(MyPreferences.instance.user!.userID).delete();
  }

  Future<HolidayMode?> getHolidayMode() async {
    try {
      DocumentSnapshot snapshot = await holidaysCollection
          .doc(MyPreferences.instance.user!.userID)
          .get();

      if (snapshot.exists) {
        return HolidayMode.fromMap(snapshot.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error getting holiday mode: $e");
      }
      return null;
    }
  }
}
