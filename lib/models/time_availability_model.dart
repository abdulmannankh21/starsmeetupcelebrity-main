class TimeAvailability {
  Map<String, DaySchedule> days;

  TimeAvailability({required this.days});
}

class DaySchedule {
  bool isOn;
  List<TimeSlot> timeSlots;

  DaySchedule({required this.isOn, required this.timeSlots});
}

class TimeSlot {
  String id;
  String startTime;
  String endTime;

  TimeSlot({required this.id, required this.startTime, required this.endTime});
  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      id: json['id'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}
