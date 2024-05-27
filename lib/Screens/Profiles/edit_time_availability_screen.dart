// ignore_for_file: must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:starsmeetupcelebrity/LocalStorage/shared_preferences.dart';

import '../../Apis/time_availability_apis.dart';
import '../../GlobalWidgets/button_widget.dart';
import '../../Utilities/app_colors.dart';
import '../../Utilities/app_text_styles.dart';
import '../../Utilities/randomiser.dart';
import '../../models/time_availability_model.dart';

class EditTimeAvailabilityScreen extends StatefulWidget {
  var day;
  EditTimeAvailabilityScreen(this.day, {super.key});

  @override
  State<EditTimeAvailabilityScreen> createState() =>
      _EditTimeAvailabilityScreenState();
}

class _EditTimeAvailabilityScreenState
    extends State<EditTimeAvailabilityScreen> {
  @override
  void initState() {
    getTimeAvailability();
    super.initState();
  }

  List<TimeSlot>? timeSlots;
  getTimeAvailability() async {
    timeSlots = await TimeAvailabilityService().getTimeAvailableForDay(
        MyPreferences.instance.user!.userID!, widget.day);
    if (kDebugMode) {
      print(timeSlots!.length);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey,
                    size: 20,
                  ),
                ),
                Text(
                  "Time Availability",
                  style: twentyTwo700TextStyle(color: purpleColor),
                ),
                GestureDetector(
                  onTap: () {
                    showTimeAvailabilityPopUp(context);
                  },
                  child: Text(
                    "Add",
                    style: sixteen400TextStyle(color: Colors.black),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            timeSlots == null
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : timeSlots != null && timeSlots!.isEmpty
                    ? const Column(
                        children: [
                          SizedBox(
                            height: 250,
                          ),
                          Center(
                            child: Text(
                              "No Time Availability Added!",
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          for (int i = 0; i < timeSlots!.length; i++)
                            Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    height: 50,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        timeSlots![i].startTime,
                                        style: fourteen400TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 50,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 0.5,
                                      ),
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Center(
                                      child: Text(
                                        timeSlots![i].endTime,
                                        style: fourteen400TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      await TimeAvailabilityService()
                                          .deleteTimeSlot(
                                            widget.day,
                                            timeSlots![i].id,
                                          )
                                          .then((value) {});
                                      getTimeAvailability();
                                    },
                                    child: Container(
                                      width: 20,
                                      height: 20,
                                      decoration: const BoxDecoration(
                                        color: redColor,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.close,
                                          color: Colors.white,
                                          size: 18,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                        ],
                      )
          ],
        ),
      ),
    );
  }

  showTimeAvailabilityPopUp(pageContext) {
    String selectedStartTime = "08:00 AM";
    String selectedEndTime = "08:00 AM";
    showGeneralDialog(
      context: pageContext,
      barrierLabel: "Barrier",
      transitionDuration: const Duration(seconds: 0),
      barrierDismissible: true,
      pageBuilder: (_, __, ___) {
        return StatefulBuilder(builder: (context, setState) {
          return Center(
            child: Material(
              color: Colors.transparent,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: MediaQuery.of(pageContext).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 280,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Select Time",
                        style: eighteen700TextStyle(color: purpleColor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          buildTimePicker("Start Time", selectedStartTime,
                              (time) {
                            setState(() {
                              selectedStartTime = time;
                            });
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          buildTimePicker("Finish Time", selectedEndTime,
                              (time) {
                            setState(() {
                              selectedEndTime = time;
                            });
                          }),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      BigButton(
                        width: MediaQuery.of(pageContext).size.width * 0.8,
                        height: 50,
                        color: purpleColor,
                        text: "Schedule",
                        onTap: () async {
                          if (isValidTimeRange(
                              selectedStartTime, selectedEndTime)) {
                            String uniqueTimeSlotId = generateUniqueId();
                            await TimeAvailabilityService()
                                .bookTimeSlot(widget.day, {
                              "id": uniqueTimeSlotId,
                              "startTime": selectedStartTime,
                              "endTime": selectedEndTime,
                            });

                            Navigator.pop(pageContext);
                            getTimeAvailability();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Invalid time range!"),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        borderRadius: 5.0,
                        textStyle: eighteen700TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }

  Widget buildTimePicker(
      String label, String selectedTime, Function(String) onTimeSelected) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 0.7,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: seventeen500TextStyle(
              color: Colors.grey[800],
            ),
          ),
          TextButton(
            onPressed: () {
              showTimePicker(
                context: context,
                initialTime: _parseTime(selectedTime),
              ).then((pickedTime) {
                if (pickedTime != null) {
                  onTimeSelected(_formatTime(pickedTime));
                }
              });
            },
            child: Text(
              selectedTime,
              style: eighteen600TextStyle(
                color: purpleColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool isValidTimeRange(String startTime, String endTime) {
    TimeOfDay startOfDay = _parseTime(startTime);
    TimeOfDay endOfDay = _parseTime(endTime);

    DateTime startDateTime =
        DateTime(2022, 1, 1, startOfDay.hour, startOfDay.minute);
    DateTime endDateTime = DateTime(2022, 1, 1, endOfDay.hour, endOfDay.minute);

    return endDateTime.isAfter(startDateTime);
  }

  TimeOfDay _parseTime(String timeString) {
    List<String> components = timeString.split(' ');
    List<int> timeComponents =
        components[0].split(':').map((e) => int.parse(e)).toList();

    if (components[1].toLowerCase() == 'pm' && timeComponents[0] != 12) {
      timeComponents[0] += 12;
    }

    return TimeOfDay(hour: timeComponents[0] % 24, minute: timeComponents[1]);
  }

  String _formatTime(TimeOfDay time) {
    int hour = time.hourOfPeriod;
    int minute = time.minute;
    String period = time.period == DayPeriod.am ? 'AM' : 'PM';

    String formattedHour = hour.toString().padLeft(2, '0');
    String formattedMinute = minute.toString().padLeft(2, '0');

    return '$formattedHour:$formattedMinute $period';
  }
}
