import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:starsmeetupcelebrity/Apis/appointment_apis.dart';
import 'package:starsmeetupcelebrity/Utilities/app_colors.dart';
import 'package:starsmeetupcelebrity/Utilities/app_text_styles.dart';
import 'package:starsmeetupcelebrity/models/appointment_model.dart';

import '../../Apis/notificationController.dart';
import '../../GlobalWidgets/button_widget.dart';
import '../../GlobalWidgets/join_meeting_button.dart';
import '../../GlobalWidgets/meetings_details_row_widget.dart';
import '../../models/notification_Model.dart';
import '../Chat/message_screen.dart';

class AppointmentDetailsScreen extends StatefulWidget {
  final AppointmentModel? appointment;

  const AppointmentDetailsScreen({Key? key, this.appointment})
      : super(key: key);

  @override
  _AppointmentDetailsScreenState createState() =>
      _AppointmentDetailsScreenState();
}

class _AppointmentDetailsScreenState extends State<AppointmentDetailsScreen> {
  late NotificationModel notification;
  NotificationController controller = Get.put(NotificationController());
  assignModel() {
    Map<String, dynamic> datee = {
      "serviceName": widget.appointment!.serviceName,
      "celebrityName": widget.appointment!.celebrityName,
      "userId": widget.appointment!.userId,
      "userName": widget.appointment!.userName,
      "creationTimestamp": DateTime.now().toString(),
      "celebrityId": widget.appointment?.celebrityId,
      "status": "cancelled",
    };
    notification = NotificationModel.fromJson(datee);

    // log("this is map data; ${notification.celebrityName}");
    setState(() {});
  }

  @override
  void initState() {
    assignModel();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppointmentModel? appointment = widget.appointment;

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
              decoration: BoxDecoration(
                color: purpleColor,
                image: appointment?.celebrityImage != null
                    ? DecorationImage(
                        image: NetworkImage(appointment!.celebrityImage!),
                        fit: BoxFit.cover,
                      )
                    : const DecorationImage(
                        image: AssetImage("assets/celebrityImage.png"),
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
                    const SizedBox(height: 10),
                    Text(
                      appointment?.userName ?? "Name",
                      style: twentyTwo700TextStyle(color: purpleColor),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "${appointment?.serviceName} Meeting: ${appointment?.serviceDuration} min",
                      style: appointment?.serviceName == 'Audio Meeting'
                          ? eighteen600TextStyle(color: redColor)
                          : eighteen600TextStyle(color: greenColor),
                    ),
                    const SizedBox(height: 30),
                    MeetingDetailsRowWidget(
                      title: "Date",
                      description: appointment?.selectedDate != null
                          ? DateFormat('MMMM dd, yyyy')
                              .format(appointment!.selectedDate!)
                          : "Date",
                    ),
                    const SizedBox(height: 15),
                    MeetingDetailsRowWidget(
                      title: "Time",
                      description:
                          "${appointment?.startTime != null ? DateFormat('hh:mm a').format(appointment!.startTime!) : ''} - ${appointment?.endTime != null ? DateFormat('hh:mm a').format(appointment!.endTime!) : ''}",
                    ),
                    const SizedBox(height: 15),
                    MeetingDetailsRowWidget(
                      title: "Total Paid",
                      description: "Rs. ${appointment?.servicePrice}",
                    ),
                    const SizedBox(height: 40),
                    JoinMeetingButton(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 55,
                      color: purpleColor,
                      widgetIcon: Container(
                        width: 35,
                        height: 35,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Center(
                          child: Image.asset(
                            appointment?.serviceName == 'Audio Meeting'
                                ? "assets/phoneIcon.png"
                                : "assets/videoCallIcon.png",
                            color: purpleColor,
                            width: 20,
                            height: 20,
                          ),
                        ),
                      ),
                      text: "Join Meeting",
                      onTap: () async {
                        print("meeting ID: ${appointment!.appointmentId!}");

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatPage(
                              meetingId: appointment!.appointmentId!,
                              appointment: appointment,
                            ),
                          ),
                        );
                        // await Navigator.pushNamed(
                        //     context,
                        //     appointment!.serviceName == 'Audio Meeting'
                        //         ? audioCallingScreenRoute
                        //         : videoCallingScreenRoute);
                        // afterCallPopUp();
                      },
                      textStyle: twenty700TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        cancelMeetingPopUp();
                      },
                      child: Text(
                        "Cancel",
                        style: eighteen600TextStyle(color: purpleColor),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void afterCallPopUp() {
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
                    const SizedBox(height: 20),
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

  void cancelMeetingPopUp() {
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
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Are you sure\nyou want to Cancel?",
                        style: twentyTwo700TextStyle(color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: BigButton(
                        width: MediaQuery.of(context).size.width * 0.7,
                        height: 50,
                        color: purpleColor,
                        text: "Cancel",
                        onTap: () {
                          AppointmentService()
                              .cancelAppointments(
                                  widget.appointment!.appointmentId!)
                              .whenComplete(() async {
                            await controller.uploadNotification(notification!);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          });
                          setState(() {});
                        },
                        borderRadius: 5.0,
                        textStyle: eighteen700TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 15),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Back",
                        style: eighteen600TextStyle(color: purpleColor),
                      ),
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
}
