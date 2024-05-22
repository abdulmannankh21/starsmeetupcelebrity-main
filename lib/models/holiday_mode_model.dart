import 'package:cloud_firestore/cloud_firestore.dart';

class HolidayMode {
  final DateTime startDate;
  final DateTime endDate;
  final int timestamp;

  HolidayMode({
    required this.startDate,
    required this.endDate,
    required this.timestamp,
  });

  factory HolidayMode.fromMap(Map<String, dynamic> map) {
    return HolidayMode(
      startDate: (map['startDate'] as Timestamp).toDate(),
      endDate: (map['endDate'] as Timestamp).toDate(),
      timestamp: map['timestamp'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'startDate': startDate,
      'endDate': endDate,
      'timestamp': timestamp,
    };
  }
}
