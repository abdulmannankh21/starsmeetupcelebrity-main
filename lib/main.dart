import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_storage/get_storage.dart';
import 'package:starsmeetupcelebrity/Screens/AppointmentScreens/upcoming_audio_appointment_details_screen.dart';

import 'Apis/agora_service.dart';
import 'Apis/push_notification_service.dart';
import 'LocalStorage/shared_preferences.dart';
import 'Screens/AppointmentScreens/appointment_screen.dart';
import 'Screens/AppointmentScreens/audio_calling_screen.dart';
import 'Screens/AppointmentScreens/cancelled_appointments_screen.dart';
import 'Screens/AppointmentScreens/completed_appointment_screen.dart';
import 'Screens/AppointmentScreens/upcoming_video_appointment_details_screen.dart';
import 'Screens/AppointmentScreens/video_appointment_details_screen.dart';
import 'Screens/AppointmentScreens/video_calling_screen.dart';
import 'Screens/Authentication/forgot_password_screen.dart';
import 'Screens/Authentication/login_screen.dart';
import 'Screens/Authentication/splash_screen.dart';
import 'Screens/HomeScreens/home_screen.dart';
import 'Screens/HomeScreens/notifications_screen.dart';
import 'Screens/HomeScreens/reviews_screen.dart';
import 'Screens/Profiles/edit_time_availability_screen.dart';
import 'Screens/Profiles/profile_screen.dart';
import 'Screens/Profiles/time_availability_screen.dart';
import 'Screens/SettingsScreens/change_password_screen.dart';
import 'Screens/SettingsScreens/help_screen.dart';
import 'Screens/SettingsScreens/holiday_mode_screen.dart';
import 'Screens/SettingsScreens/privacy_policy_screen.dart';
import 'Screens/SettingsScreens/settings_screen.dart';
import 'Screens/SettingsScreens/support_your_star_settings_screen.dart';
import 'Screens/SettingsScreens/terms_of_use_screen.dart';
import 'Utilities/app_routes.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message)async {
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await MyPreferences.instance.init();

  await GetStorage.init();
  final pushNotificationService = PushNotificationService();
  // await pushNotificationService.initialize();
  // final agoraService = AgoraService();
  // await agoraService.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // _initializeFirebaseMessaging();

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    print("Handling a background message: ${message.messageId}");

    // Handle the incoming message here
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      initialRoute: splashScreenRoute,
      builder: EasyLoading.init(),
      routes: {
        splashScreenRoute: (context) => const SplashScreen(),
        loginScreenRoute: (context) => const LoginScreen(),
        homeScreenRoute: (context) => const HomeScreen(),
        audioCallingScreenRoute: (context) => const AudioCallingScreen(),
        forgotPasswordScreenRoute: (context) => const ForgotPasswordScreen(),
        videoCallingScreenRoute: (context) => const VideoCallingScreen(),
        profileScreenRoute: (context) => const ProfileScreen(),
        settingsScreenRoute: (context) => const SettingsScreen(),
        helpScreenRoute: (context) => const HelpScreen(),
        reviewsScreenRoute: (context) => const ReviewsScreen(),
        privacyPolicyScreenRoute: (context) => const PrivacyPolicyScreen(),
        upcomingVideoAppointmentDetailsScreenRoute: (context) =>
            const UpcomingVideoAppointmentDetailsScreen(),
        upcomingAudioAppointmentDetailsScreenRoute: (context) =>
            const UpcomingAudioAppointmentDetailsScreen(),
        termsOfUseScreenRoute: (context) => const TermsOfUseScreen(),
        notificationsScreenRoute: (context) => NotificationsScreen(),
        holidayModeScreenRoute: (context) => const HolidayModeScreen(),
        cancelledAppointmentScreenRoute: (context) =>
            const CancelledAppointmentScreen(),
        completedAppointmentScreenRoute: (context) =>
            const CompletedAppointmentScreen(),
        appointmentScreenRoute: (context) => const AppointmentScreen(),
        changePasswordScreenRoute: (context) => const ChangePasswordScreen(),
        editTimeAvailabilityScreenRoute: (context) {
          var i = ModalRoute.of(context)!.settings.arguments;
          return EditTimeAvailabilityScreen(i);
        },
        timeAvailabilityScreenRoute: (context) =>
            const TimeAvailabilityScreen(),
        supportYourStarSettingsScreenRoute: (context) =>
            const SupportYourStarSettingsScreen(),
        videoAppointmentDetailsScreenRoute: (context) =>
            const VideoAppointmentDetailsScreen(),
        // audioAppointmentDetailsScreenRoute: (context) =>
        //     AudioAppointmentDetailsScreen(),
      },
    );
  }
}
