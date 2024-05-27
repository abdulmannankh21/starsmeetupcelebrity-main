import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Apis/appointment_apis.dart';
import '../../Apis/history_controller.dart';
import '../../GlobalWidgets/button_widget.dart';
import '../../GlobalWidgets/upcoming_appointment_widget.dart';
import '../../Utilities/app_colors.dart';
import '../../Utilities/app_text_styles.dart';
import '../../models/appointment_model.dart';
import '../../models/historyModel.dart';
import 'audio_appointment_details_screen.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({Key? key}) : super(key: key);

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late HistoryController _historyController;
  int currentTabIndex = 0;
  String selectedStatus = 'All';
  Stream<List<AppointmentModel>>? appointmentStream;
  Stream<List<HistoryModel>>? historyStream;

  final List<String> status = [
    'All',
    'Completed',
    'No Show',
  ];

  final List<String> days = [
    'All',
    'This month',
    'This year',
    'Custom',
  ];

  final AppointmentService _appointmentService = AppointmentService();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          currentTabIndex = _tabController.index;
        });
      }
    });
    _historyController = Get.put(HistoryController());
    loadStreams();
  }

  void loadStreams() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (currentTabIndex == 0) {
        appointmentStream = _appointmentService
            .getAllAppointmentsByCelebrityIdStream(user.email!);
      } else {
        historyStream = null;
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
                  "Appointments",
                  style: twentyTwo700TextStyle(color: purpleColor),
                ),
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: "Upcoming"),
                  Tab(text: "History"),
                ],
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.white,
                unselectedLabelStyle: eighteen600TextStyle(
                  color: Colors.grey,
                ),
                labelStyle: eighteen700TextStyle(
                  color: Colors.white,
                ),
                onTap: (index) {
                  setState(() {
                    currentTabIndex = index;
                    loadStreams(); // Reload streams on tab change
                  });
                },
                unselectedLabelColor: Colors.grey[600],
                indicator: ShapeDecoration(
                  color: purpleColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(currentTabIndex == 0 ? 5 : 0),
                      topRight: Radius.circular(currentTabIndex == 0 ? 0 : 5),
                      bottomLeft: Radius.circular(currentTabIndex == 0 ? 5 : 0),
                      bottomRight:
                          Radius.circular(currentTabIndex == 0 ? 0 : 5),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  showFilterPopUp(context);
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
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  // Upcoming Tab
                  _buildUpcomingListView(),
                  // History Tab
                  _buildHistoryListView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingListView() {
    return StreamBuilder<List<AppointmentModel>>(
      stream: appointmentStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No Upcoming Appointments Available'));
        } else {
          List<AppointmentModel> data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return UpcomingAppointmentWidget(
                name: data[index].celebrityName!,
                meetingType: data[index].serviceName!,
                celebrityImage: data[index].celebrityImage!,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AppointmentDetailsScreen(
                        appointment: data[index],
                      ),
                    ),
                  );
                  // log("this is appointmentIndex: ${appointments[index].toJson()}");
                },
                // Add other properties as needed
              );
            },
          );
        }
      },
    );
  }

  Widget _buildHistoryListView() {
    return StreamBuilder<List<HistoryModel>>(
      stream: historyStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No History Available'));
        } else {
          List<HistoryModel> data = snapshot.data!;
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              return UpcomingAppointmentWidget(
                name: data[index].celebrityName!,
                meetingType: data[index].serviceName!,
                celebrityImage: data[index].celebrityImage!,
                onTap: () {
                  // log("this is appointmentIndex: ${appointments[index].toJson()}");
                },
                // Add other properties as needed
              );
            },
          );
        }
      },
    );
  }

  void showFilterPopUp(pageContext) {
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
                  height: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Filter",
                          style: twentyFive700TextStyle(color: purpleColor),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        "Status",
                        style: eighteen700TextStyle(color: purpleColor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      Container(
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
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            padding: EdgeInsets.zero,
                            isExpanded: true,
                            value: selectedStatus,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedStatus = newValue!;
                              });
                            },
                            items: status
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            style: eighteen500TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const SizedBox(width: 1),
                            Text(
                              "Cancel",
                              style: eighteen600TextStyle(
                                color: purpleColor,
                              ),
                            ),
                            BigButton(
                              width:
                                  MediaQuery.of(pageContext).size.width * 0.4,
                              height: 45,
                              color: purpleColor,
                              text: "Apply",
                              onTap: () {
                                _handleApplyButtonTap(pageContext);
                              },
                              borderRadius: 5.0,
                              textStyle:
                                  eighteen700TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
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

  void _handleApplyButtonTap(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      // Depending on the current tab, reload the respective stream
      if (currentTabIndex == 0) {
        // Cancel previous stream subscription
        // Assign a new stream
        appointmentStream = _appointmentService
            .getAllAppointmentsByCelebrityIdStream(user!.email!);
      } else {
        // Cancel previous stream subscription
        // Assign a new stream
        historyStream = null;
      }
      Navigator.pop(context);
    });
  }
}
