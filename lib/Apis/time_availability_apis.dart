import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:starsmeetupcelebrity/LocalStorage/shared_preferences.dart';

import '../models/time_availability_model.dart';

class TimeAvailabilityService {
  final CollectionReference bookingsCollection =
      FirebaseFirestore.instance.collection('timeAvailability');

  Future<void> setInitialDocument(String userId) async {
    try {
      await bookingsCollection.doc(userId).set({
        'days': {
          'Monday': {
            'isOn': true,
            'timeSlots': [],
          },
          'Tuesday': {
            'isOn': false,
            'timeSlots': [],
          },
          'Wednesday': {
            'isOn': false,
            'timeSlots': [],
          },
          'Thursday': {
            'isOn': false,
            'timeSlots': [],
          },
          'Friday': {
            'isOn': false,
            'timeSlots': [],
          },
          'Saturday': {
            'isOn': false,
            'timeSlots': [],
          },
          'Sunday': {
            'isOn': false,
            'timeSlots': [],
          },
        }
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error setting initial document: $e");
      }
    }
  }

  Future<void> bookTimeSlot(String day, Map<String, String> timeSlot) async {
    try {
      await bookingsCollection.doc(MyPreferences.instance.user!.userID).update({
        'days.$day.timeSlots': FieldValue.arrayUnion([timeSlot]),
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error booking time slot: $e");
      }
    }
  }

  bool isTimeSlotAvailable(TimeSlot timeSlot) {
    return true;
  }

  Future<List<TimeSlot>> getTimeAvailableForDay(
      String userId, String day) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await bookingsCollection
          .doc(userId)
          .get() as DocumentSnapshot<Map<String, dynamic>>;

      if (userDoc.exists) {
        Map<String, dynamic>? daysData = userDoc.data()?['days'];

        if (daysData != null && daysData.containsKey(day)) {
          dynamic dayData = daysData[day];

          if (dayData != null && dayData['timeSlots'] != null) {
            List<dynamic> timeSlotsData = dayData['timeSlots'];

            List<TimeSlot> timeSlots = timeSlotsData.map((slotData) {
              return TimeSlot(
                id: slotData['id'] ?? '',
                startTime: slotData['startTime'] ?? '',
                endTime: slotData['endTime'] ?? '',
              );
            }).toList();

            return timeSlots;
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error getting time available for day: $e");
      }
    }

    return [];
  }

  Future<List<bool>> getTimeAvailabilityStatusAsList() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userDoc = await bookingsCollection
          .doc(MyPreferences.instance.user!.userID)
          .get() as DocumentSnapshot<Map<String, dynamic>>;

      if (userDoc.exists) {
        Map<String, dynamic>? daysMap = userDoc.data()?['days'];

        if (daysMap != null) {
          List<bool> availabilityStatusList = [
            daysMap['Monday']?['isOn'] ?? false,
            daysMap['Tuesday']?['isOn'] ?? false,
            daysMap['Wednesday']?['isOn'] ?? false,
            daysMap['Thursday']?['isOn'] ?? false,
            daysMap['Friday']?['isOn'] ?? false,
            daysMap['Saturday']?['isOn'] ?? false,
            daysMap['Sunday']?['isOn'] ?? false,
          ];

          return availabilityStatusList;
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error getting time availability status: $e");
      }
    }

    return List.filled(7, false);
  }

  Future<void> updateTimeAvailabilityStatus(String day, bool isOn) async {
    try {
      await bookingsCollection.doc(MyPreferences.instance.user!.userID).update({
        'days.$day.isOn': isOn,
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> deleteTimeSlot(String day, String timeSlotId) async {
    try {
      final userId = MyPreferences.instance.user!.userID;
      if (kDebugMode) {
        print('Deleting time slot: $timeSlotId for day: $day, user: $userId');
      }

      DocumentSnapshot<Map<String, dynamic>> userDoc = await bookingsCollection
          .doc(userId)
          .get() as DocumentSnapshot<Map<String, dynamic>>;

      if (userDoc.exists) {
        Map<String, dynamic>? daysData = userDoc.data()?['days'];

        if (daysData != null && daysData.containsKey(day)) {
          dynamic dayData = daysData[day];

          if (dayData != null && dayData['timeSlots'] != null) {
            List<dynamic> timeSlotsData = dayData['timeSlots'];

            int indexToDelete = timeSlotsData.indexWhere(
              (slotData) => slotData['id'] == timeSlotId,
            );

            if (indexToDelete != -1) {
              if (kDebugMode) {
                print('Index to delete: $indexToDelete');
              }

              await bookingsCollection.doc(userId).update({
                'days.$day.timeSlots':
                    FieldValue.arrayRemove([timeSlotsData[indexToDelete]])
              }).then((_) {
                if (kDebugMode) {
                  print("Deleted");
                }
              });
            } else {
              if (kDebugMode) {
                print('Time slot with id $timeSlotId not found.');
              }
            }
          }
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error deleting time slot: $e");
      }
    }
  }
}
