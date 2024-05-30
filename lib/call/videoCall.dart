import 'dart:developer';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:get/get.dart';

class AgoraCalls extends StatefulWidget {
  String channelName;
  DateTime endTime;
  String Name;
  AgoraCalls(
      {super.key,
      required this.channelName,
      required this.endTime,
      required this.Name});

  @override
  State<AgoraCalls> createState() => _AgoraCallsState();
}

class _AgoraCallsState extends State<AgoraCalls> {
  static const appId = "989f207f2a12441a9c71a5db1ee4eeac";
  static const token = "";
  static String channel = "Test_Channel";
  int? _remoteUid;
  bool _localUserJoined = false;
  late RtcEngine _engine;
  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
      appId: "989f207f2a12441a9c71a5db1ee4eeac",
      channelName: channel,
      username: "user",
    ),
  );

  RxBool mute = false.obs;
  RxBool camera = false.obs;
  RxBool Ui = false.obs;
  void initState() {
    super.initState();

    // initAgora();
    channel = widget.channelName;
    // initAgora();
    if (channel != "" || channel != null) {
      initAgora();
    } else {
      Navigator.pop(context);
    }
  }

  void initAgora() async {
    await client.initialize();
    client.engine.registerEventHandler(RtcEngineEventHandler(
      onJoinChannelSuccess: (connection, remoteUid) {
        log("this is channel id: ${connection.channelId}");
      },
      onUserJoined: (connection, remoteUid, elapsed) async {
        Ui.value = true;

        log("user is jpoined");
      },
      onLeaveChannel: (connection, stats) async {
        log("user is not jpoined: ${connection.channelId}");
        Ui.value = true;
        await client.engine.leaveChannel();
      },
    ));
    await client.engine.joinChannel(
        token: "", channelId: channel, uid: 0, options: ChannelMediaOptions());
    // await client.engine.j();
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

            disableVideoButtonChild: Obx(
              () => GestureDetector(
                onTap: () async {
                  if (camera.value == false) {
                    camera.value = true;
                    await client.engine.disableVideo();
                    // _engine.disableVideo();
                  } else {
                    camera.value = false;
                    await client.engine.enableVideo();
                  }
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.6)),
                  child: Icon(
                    camera.value == false ? Icons.videocam : Icons.videocam_off,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            muteButtonChild: Obx(
              () => GestureDetector(
                onTap: () async {
                  if (mute.value == false) {
                    mute.value = true;
                    await client.engine.disableAudio();
                    // _engine.disableVideo();`
                  } else {
                    mute.value = false;
                    await client.engine.enableAudio();
                  }
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.withOpacity(0.6)),
                  child: Icon(
                    mute.value == false ? Icons.mic : Icons.mic_external_off,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            enabledButtons: [
              BuiltInButtons.callEnd,
              BuiltInButtons.toggleCamera,
              BuiltInButtons.toggleMic
            ],
          ),
          Positioned(
            top: 25,
            left: 15,
            child: Column(
              children: [
                Text(
                  "${widget.Name.toString()}",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600),
                ),
                Row(
                  children: [
                    Text(
                      "Will End ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    TimerCountdown(
                      spacerWidth: 5,
                      enableDescriptions: false,
                      timeTextStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                      minutesDescription: "",
                      secondsDescription: "",
                      colonsTextStyle: TextStyle(color: Colors.white),
                      format: CountDownTimerFormat.minutesSeconds,
                      endTime: widget.endTime,
                      onEnd: () {
                        print("Timer finished");
                        _dispose();
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: 40,
            right: 0,
            child: AgoraVideoButtons(
              switchCameraButtonChild: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.withOpacity(0.6)),
                child: Icon(
                  Icons.switch_camera,
                  color: Colors.white,
                ),
              ),
              buttonAlignment: Alignment.centerRight,
              client: client,
              addScreenSharing: false,
              enabledButtons: [
                BuiltInButtons.switchCamera,
              ],
            ),
          ),
          Ui.value == false
              ? Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              : SizedBox(),
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
