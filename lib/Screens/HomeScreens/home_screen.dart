import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:starsmeetupcelebrity/Apis/appointment_apis.dart';
import 'package:starsmeetupcelebrity/LocalStorage/shared_preferences.dart';
import 'package:starsmeetupcelebrity/Utilities/app_colors.dart';
import 'package:starsmeetupcelebrity/Utilities/app_text_styles.dart';

import '../../Apis/user_apis.dart';
import '../../GlobalWidgets/side_drawer_widget.dart';
import '../../Utilities/app_routes.dart';
import '../../models/appointment_model.dart';
import '../../notification_service.dart';
import '../AppointmentScreens/audio_appointment_details_screen.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<bool> isOpened = [false, false, false];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }
  NotificationServices notificationServices = NotificationServices();

  @override
  void initState() {
    _initializeFirebaseMessaging();
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();

    notificationServices.getDeviceToken().then((value){
      if (kDebugMode) {
        print('device token');
        print(value);
      }
    });
    super.initState();
  }

  void _initializeFirebaseMessaging() async {
    _firebaseMessaging.requestPermission();

    // Retrieve user ID from preferences
    var userID = MyPreferences.instance.user?.userID;

    if (userID != null) {
      _firebaseMessaging.getToken().then((String? token) async {
        print("FCM Token: $token");
        if (token != null) {
          await UserService().updateFCMToken(userID, token);
        }
      });

      _firebaseMessaging.onTokenRefresh.listen((String? token) async {
        print("FCM Token refreshed: $token");
        if (token != null) {
          await UserService().updateFCMToken(userID, token);
        }
      });
    } else {
      print("User ID is null");
    }

    // Handle incoming messages when the app is in the foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: ${message.data}");
    });

    // Handle incoming messages when the app is in the background but opened by tapping the notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: $message");
    });

    // Handle incoming messages when the app is terminated and opened by tapping the notification
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message) async {
      print("onBackgroundMessage: $message");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawerScrimColor: Colors.transparent,
      backgroundColor: Colors.white,
      drawer: DrawerWidget(scaffoldKey: _scaffoldKey),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: openDrawer,
                  child: Image.asset(
                    "assets/sideMenuIcon.png",
                    width: 25,
                    height: 25,
                  ),
                ),
                Image.asset(
                  "assets/logo.png",
                  width: 200,
                  height: 30,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, notificationsScreenRoute);
                  },
                  child: Image.asset(
                    "assets/notificationsIcon.png",
                    width: 20,
                    height: 20,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Welcome",
                  style: twentySix700TextStyle(
                    color: Colors.black,
                  ),
                ),
                Text(
                  MyPreferences.instance.user!.name ?? "Loading...",
                  style: eighteen700TextStyle(
                    color: purpleColor,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Center(
                  child: Text(
                    "Appointments",
                    style: twentyFour700TextStyle(
                      color: purpleColor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
            thickness: 1.5,
          ),
          Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            DateFormat('EEEE MMMM,d').format(DateTime.now()),
                            style: twenty600TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          StreamBuilder<List<AppointmentModel>>(
                            stream: AppointmentService()
                                .getTodayAppointmentsByCelebrityIdStream(
                                    MyPreferences.instance.user!.userID!),
                            builder: (BuildContext context,
                                AsyncSnapshot<List<AppointmentModel>>
                                    snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              } else if (snapshot.hasError) {
                                return Center(
                                    child: Text('Error: ${snapshot.error}'));
                              } else if (!snapshot.hasData ||
                                  snapshot.data!.isEmpty) {
                                return Center(
                                    child: Text('No appointments available'));
                              } else {
                                List<AppointmentModel> celebrityAppointments =
                                    snapshot.data!;
                                return Column(
                                  children: [
                                    for (int i = 0;
                                        i < celebrityAppointments.length;
                                        i++)
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AppointmentDetailsScreen(
                                                appointment:
                                                    celebrityAppointments[i],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Container(
                                          margin:
                                              const EdgeInsets.only(bottom: 17),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.9,
                                          height: 90,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
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
                                                decoration: celebrityAppointments[
                                                                i]
                                                            .celebrityImage ==
                                                        ""
                                                    ? BoxDecoration(
                                                        image: const DecorationImage(
                                                            image: AssetImage(
                                                                "assets/dummProfileIcon.png"),
                                                            fit: BoxFit.cover),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      )
                                                    : BoxDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              celebrityAppointments[
                                                                      i]
                                                                  .celebrityImage!),
                                                          fit: BoxFit.cover,
                                                        ),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10.0),
                                                      ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(
                                                        celebrityAppointments[i]
                                                                .userName ??
                                                            "",
                                                        style:
                                                            eighteen700TextStyle(
                                                          color: purpleColor,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${DateFormat('hh:mm a').format(celebrityAppointments[i].startTime!)} - ${DateFormat('hh:mm a').format(celebrityAppointments[i].endTime!)}",
                                                        style:
                                                            fourteen400TextStyle(),
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
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
