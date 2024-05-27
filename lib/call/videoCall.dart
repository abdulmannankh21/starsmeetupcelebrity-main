import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:agora_uikit/models/agora_connection_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AgoraCalls extends StatefulWidget {
  String channelName;
  AgoraCalls({super.key, required this.channelName});

  @override
  State<AgoraCalls> createState() => _AgoraCallsState();
}

class _AgoraCallsState extends State<AgoraCalls> {
  static const appId = "989f207f2a12441a9c71a5db1ee4eeac";
  static const token = "";
  static String channel = "";
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: "989f207f2a12441a9c71a5db1ee4eeac",
      channelName: channel,
      username: "user",
    ),
  );
  void initState() {
    super.initState();
    channel = widget.channelName;
    // initAgora();
    if (channel != "" || channel != null) {
      initAgora();
    } else {
      Navigator.pop(context);
    }
    setState(() {});
  }

  getCurrentUserChannel() async {
    User? user = await FirebaseAuth.instance.currentUser;
    print("this is user " + user!.email!);
  }

  void initAgora() async {
    await client.initialize();
  }

  @override
  void dispose() {
    super.dispose();

    _dispose();
  }

  Future<void> _dispose() async {
    await _engine.leaveChannel();
    await _engine.release();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agora Video Call'),
      ),
      body: Stack(
        children: [
          AgoraVideoViewer(
            client: client,
            layoutType: Layout.floating,
            enableHostControls: true, // Add this to enable host controls
          ),
          AgoraVideoButtons(
            client: client,
            addScreenSharing: false, // Add this to enable screen sharing
          ),
          // Center(
          //   child: _remoteVideo(),
          // ),
          // Align(
          //   alignment: Alignment.topLeft,
          //   child: SizedBox(
          //     width: 100,
          //     height: 150,
          //     child: Center(
          //       child: _localUserJoined
          //           ? AgoraVideoView(
          //               controller: VideoViewController(
          //                 rtcEngine: _engine,
          //                 canvas: const VideoCanvas(uid: 0),
          //               ),
          //             )
          //           : const CircularProgressIndicator(),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  // Display remote user's video
  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid),
          connection: RtcConnection(channelId: channel),
        ),
      );
    } else {
      return const Text(
        'Please wait for remote user to join',
        textAlign: TextAlign.center,
      );
    }
  }
}
