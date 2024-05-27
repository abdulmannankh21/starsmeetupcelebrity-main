import 'package:flutter/material.dart';
import 'package:starsmeetupcelebrity/GlobalWidgets/button_widget.dart';

import '../../GlobalWidgets/meetings_details_row_widget.dart';
import '../../Utilities/app_colors.dart';
import '../../Utilities/app_text_styles.dart';

class CompletedAppointmentScreen extends StatefulWidget {
  const CompletedAppointmentScreen({super.key});

  @override
  State<CompletedAppointmentScreen> createState() =>
      _CompletedAppointmentScreenState();
}

class _CompletedAppointmentScreenState
    extends State<CompletedAppointmentScreen> {
  bool i = false;
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
                      height: 40,
                    ),
                    BigButton(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 55,
                      color: i ? redColor : greenColor,
                      text: i ? "No Show" : "Completed",
                      onTap: () {
                        i = !i;
                        setState(() {});
                      },
                      textStyle: twenty700TextStyle(color: Colors.white),
                    ),
                    const SizedBox(
                      height: 50,
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
}
