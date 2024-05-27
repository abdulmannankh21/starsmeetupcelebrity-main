import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

// import '../Screens/Calling/Video/video_call_screen.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future<void> initialize(BuildContext context) async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        _handleMessage(context, message);
      });

      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        _handleMessage(context, message);
      });
    }
  }

  void _handleMessage(BuildContext context, RemoteMessage message) {
    if (message.data['type'] == 'video_call') {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => VideoCallScreen(
      //       channelName: message.data['channel_name'],
      //       token: message.data['token'],
      //     ),
      //   ),
      // );
    }
  }
}
