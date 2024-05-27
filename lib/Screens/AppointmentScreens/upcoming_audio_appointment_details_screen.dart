// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:starsmeetupcelebrity/Utilities/app_colors.dart';
import 'package:starsmeetupcelebrity/Utilities/app_text_styles.dart';

import '../../GlobalWidgets/button_widget.dart';
import '../../GlobalWidgets/meetings_details_row_widget.dart';

class UpcomingAudioAppointmentDetailsScreen extends StatefulWidget {
  const UpcomingAudioAppointmentDetailsScreen({super.key});

  @override
  State<UpcomingAudioAppointmentDetailsScreen> createState() =>
      _UpcomingAudioAppointmentDetailsScreenState();
}

class _UpcomingAudioAppointmentDetailsScreenState
    extends State<UpcomingAudioAppointmentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.5,
              decoration: const BoxDecoration(
                color: purpleColor,
                image: DecorationImage(
                  image: AssetImage(
                    "assets/celebrityImage.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 30,
              left: 20,
              right: 20,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(
                    color: purpleColor,
                    width: 2,
                  ),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Faizan Azhar",
                      style: twentyTwo700TextStyle(color: purpleColor),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Audio Meeting: 2 min",
                      style: eighteen600TextStyle(color: redColor),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    const MeetingDetailsRowWidget(
                      title: "Date",
                      description: "March 15, 2024",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const MeetingDetailsRowWidget(
                      title: "Time",
                      description: "07:50 PM - 08:00 PM",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const MeetingDetailsRowWidget(
                      title: "Country",
                      description: "Pakistan",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const MeetingDetailsRowWidget(
                      title: "Total Paid",
                      description: "Rs.2,000",
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    GestureDetector(
                      onTap: () {
                        cancelMeetingPopUp();
                      },
                      child: Text(
                        "Cancel",
                        style: eighteen600TextStyle(color: purpleColor),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  afterCallPopUp() {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      transitionDuration: const Duration(seconds: 0),
      barrierDismissible: true,
      pageBuilder: (_, __, ___) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        BigButton(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: 50,
                          color: redColor,
                          text: "No Show",
                          onTap: () {},
                          borderRadius: 5.0,
                          textStyle: eighteen700TextStyle(color: Colors.white),
                        ),
                        BigButton(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: 50,
                          color: greenColor,
                          text: "Completed",
                          onTap: () {
                            Navigator.pop(context);
                            setState(() {});
                          },
                          borderRadius: 5.0,
                          textStyle: eighteen700TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  cancelMeetingPopUp() {
    showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      transitionDuration: const Duration(seconds: 0),
      barrierDismissible: true,
      pageBuilder: (_, __, ___) {
        return Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(10.0),
              child: SizedBox(
                height: 220,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Are you sure\nyou want to Cancel?",
                        style: twentyTwo700TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: BigButton(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 50,
                        color: purpleColor,
                        text: "Cancel",
                        onTap: () {},
                        borderRadius: 5.0,
                        textStyle: eighteen700TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      "Back",
                      style: eighteen600TextStyle(
                        color: purpleColor,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
