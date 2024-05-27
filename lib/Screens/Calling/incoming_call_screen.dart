import 'package:flutter/material.dart';

// import 'Video/video_call_screen.dart';

class IncomingCallScreen extends StatelessWidget {
  final String channelName;
  final String token;

  IncomingCallScreen({required this.channelName, required this.token});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Incoming Call')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) =>
            //         VideoCallScreen(channelName: channelName, token: token),
            //   ),
            // );
          },
          child: Text('Accept Call'),
        ),
      ),
    );
  }
}
