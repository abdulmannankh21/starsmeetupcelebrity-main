import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:starsmeetupcelebrity/Apis/time_availability_apis.dart';

import '../../Utilities/app_colors.dart';
import '../../Utilities/app_routes.dart';
import '../../Utilities/app_text_styles.dart';

class TimeAvailabilityScreen extends StatefulWidget {
  const TimeAvailabilityScreen({super.key});

  @override
  State<TimeAvailabilityScreen> createState() => _TimeAvailabilityScreenState();
}

class _TimeAvailabilityScreenState extends State<TimeAvailabilityScreen> {
  List<bool> availabilityStatusList = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];

  @override
  void initState() {
    super.initState();
    getTimeSlotsOnOff();
  }

  Future<void> getTimeSlotsOnOff() async {
    try {
      List<bool> result =
          await TimeAvailabilityService().getTimeAvailabilityStatusAsList();

      setState(() {
        availabilityStatusList = result;
      });
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching data: $e");
      }
    }
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
                const SizedBox(
                  width: 30,
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            for (int i = 0; i < 7; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    i == 0
                        ? "Monday"
                        : i == 1
                            ? "Tuesday"
                            : i == 2
                                ? "Wednesday"
                                : i == 3
                                    ? "Thursday"
                                    : i == 4
                                        ? "Friday"
                                        : i == 5
                                            ? "Saturday"
                                            : "Sunday",
                    style: eighteen800TextStyle(
                      color: purpleColor,
                    ),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, editTimeAvailabilityScreenRoute,
                              arguments: i == 0
                                  ? "Monday"
                                  : i == 1
                                      ? "Tuesday"
                                      : i == 2
                                          ? "Wednesday"
                                          : i == 3
                                              ? "Thursday"
                                              : i == 4
                                                  ? "Friday"
                                                  : i == 5
                                                      ? "Saturday"
                                                      : "Sunday");
                        },
                        child: Text(
                          "Edit",
                          style: sixteen400TextStyle(
                            color: Colors.black.withOpacity(0.7),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Switch(
                        value: availabilityStatusList[i],
                        onChanged: (val) {
                          availabilityStatusList[i] = val;
                          setState(() {});
                          TimeAvailabilityService()
                              .updateTimeAvailabilityStatus(
                                  i == 0
                                      ? "Monday"
                                      : i == 1
                                          ? "Tuesday"
                                          : i == 2
                                              ? "Wednesday"
                                              : i == 3
                                                  ? "Thursday"
                                                  : i == 4
                                                      ? "Friday"
                                                      : i == 5
                                                          ? "Saturday"
                                                          : "Sunday",
                                  availabilityStatusList[i])
                              .then((value) {
                            getTimeSlotsOnOff();
                          });
                        },
                        activeColor: Colors.white,
                        trackColor: MaterialStatePropertyAll(
                          availabilityStatusList[i] == true
                              ? purpleColor
                              : Colors.grey[200],
                        ),
                      )
                    ],
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
