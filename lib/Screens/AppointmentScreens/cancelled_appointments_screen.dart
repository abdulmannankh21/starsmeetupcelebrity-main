import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../Utilities/app_colors.dart';
import '../../Utilities/app_text_styles.dart';
import '../../models/appointment_model.dart';

class CancelledAppointmentScreen extends StatefulWidget {
  const CancelledAppointmentScreen({Key? key}) : super(key: key);

  @override
  State<CancelledAppointmentScreen> createState() =>
      _CancelledAppointmentScreenState();
}

class _CancelledAppointmentScreenState
    extends State<CancelledAppointmentScreen> {
  String _selectedStatus = 'All';
  final List<String> _statusOptions = ['All', 'Cancelled', 'Completed'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 50),
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
                  "Cancelled Appointments",
                  style: twentyTwo700TextStyle(color: purpleColor),
                ),
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  _showFilterDialog(context);
                },
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                    child: Image.asset(
                      "assets/filterIcon.png",
                      width: 20,
                      height: 20,
                      color: purpleColor,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: CancelledAppointmentList(),
            ),
          ],
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Filter'),
          content: DropdownButtonFormField<String>(
            value: _selectedStatus,
            items: _statusOptions
                .map((status) => DropdownMenuItem(
                      child: Text(status),
                      value: status,
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedStatus = value!;
              });
              Navigator.pop(context);
            },
          ),
        );
      },
    );
  }
}

class CancelledAppointmentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('appointments')
          .where('status', isEqualTo: 'cancelled')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Text('No data available');
        } else {
          final appointments = snapshot.data!.docs;
          return ListView.builder(
            itemCount: appointments.length,
            itemBuilder: (context, index) {
              final appointment = AppointmentModel.fromJson(
                appointments[index].data() as Map<String, dynamic>,
                appointments[index].id, // Pass document ID
              );
              print(appointment);
              return CancelledAppointmentWidget(appointment: appointment);
            },
          );
        }
      },
    );
  }
}

class CancelledAppointmentWidget extends StatelessWidget {
  final AppointmentModel appointment;

  const CancelledAppointmentWidget({Key? key, required this.appointment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final customerName = appointment.userName ?? 'N/A';
    final startTime = appointment.startTime;
    final endTime = appointment.endTime;
    final appointmentPictureCelebrity = appointment.celebrityImage;

    return GestureDetector(
      onTap: () {
        // Handle onTap
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
              decoration: appointmentPictureCelebrity == ""
                  ? BoxDecoration(
                      image: const DecorationImage(
                          image: AssetImage("assets/dummProfileIcon.png"),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10.0),
                    )
                  : BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(appointmentPictureCelebrity!),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      customerName,
                      style: eighteen700TextStyle(
                        color: purpleColor,
                      ),
                    ),
                    Text(
                      "${DateFormat('hh:mm a').format(startTime!)} - ${DateFormat('hh:mm a').format(endTime!)}",
                      style: fourteen400TextStyle(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
