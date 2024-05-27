import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Screens/AppointmentScreens/cancelled_appointment_details_screen.dart';
import '../Utilities/app_colors.dart';
import '../Utilities/app_text_styles.dart';
import '../models/appointment_model.dart';

class UpcomingAppointmentWidget extends StatefulWidget {
  final String name;
  final String meetingType;
  final String celebrityImage;
  final VoidCallback? onTap;

  UpcomingAppointmentWidget({
    required this.name,
    required this.meetingType,
    required this.celebrityImage,
    this.onTap,
  });

  @override
  State<UpcomingAppointmentWidget> createState() =>
      _UpcomingAppointmentWidgetState();
}

class _UpcomingAppointmentWidgetState extends State<UpcomingAppointmentWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: widget.onTap,
          child: Container(
            margin: const EdgeInsets.only(bottom: 17),
            width: MediaQuery.of(context).size.width * 0.9,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                      image: NetworkImage(
                        "${widget.celebrityImage}",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.name,
                              style: eighteen700TextStyle(
                                color: purpleColor,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.meetingType,
                              style: fourteen600TextStyle(
                                color: widget.meetingType == 'Audio Meeting'
                                    ? redColor
                                    : greenColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class HistoryAppointmentWidget extends StatefulWidget {
  final int count;
  final VoidCallback onTap;
  const HistoryAppointmentWidget(
      {super.key, required this.count, required this.onTap});

  @override
  State<HistoryAppointmentWidget> createState() =>
      _HistoryAppointmentWidgetState();
}

class _HistoryAppointmentWidgetState extends State<HistoryAppointmentWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < widget.count; i++)
          GestureDetector(
            onTap: widget.onTap,
            child: Container(
              margin: const EdgeInsets.only(bottom: 17),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: const DecorationImage(
                        image: AssetImage(
                          "assets/celebrityImage.png",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Faizan Azhar",
                                style: eighteen700TextStyle(
                                  color: purpleColor,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                i % 2 == 0 ? "Audio Meeting" : "Video Meeting",
                                style: fourteen600TextStyle(
                                  color: i % 2 == 0 ? redColor : greenColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class CancelledAppointmentWidget extends StatefulWidget {
  final int count;
  List<AppointmentModel> appointment;
  CancelledAppointmentWidget({
    super.key,
    required this.count,
    required this.appointment,
  });

  @override
  State<CancelledAppointmentWidget> createState() =>
      _CancelledAppointmentWidgetState();
}

class _CancelledAppointmentWidgetState
    extends State<CancelledAppointmentWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (int i = 0; i < widget.count; i++)
          GestureDetector(
            onTap: () {
              log("this is index ${i}");
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CancelledAppointmentDetailsScreen(
                            appointmentModel: widget.appointment[i],
                          )),
                );
              });
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 17),
              width: MediaQuery.of(context).size.width * 0.9,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    width: 60,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(
                          "${widget.appointment[i].celebrityImage}",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${widget.appointment[i].celebrityName}",
                                style: eighteen700TextStyle(
                                  color: purpleColor,
                                ),
                              ),
                              Text(
                                "${DateFormat('h:mm a').format(widget.appointment[i].startTime!)}",
                                style: twelve400TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${widget.appointment[i].serviceName}",
                                style: fourteen600TextStyle(
                                  color: widget.appointment[i].serviceName ==
                                          "Audio Meeting"
                                      ? redColor
                                      : greenColor,
                                ),
                              ),
                              Text(
                                "${DateFormat('MMMM d, yy').format(widget.appointment[i].startTime!)}",
                                style: twelve400TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
      ],
    );
  }
}
