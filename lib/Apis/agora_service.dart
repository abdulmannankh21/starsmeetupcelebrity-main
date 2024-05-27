// import 'package:agora_rtc_engine/rtc_engine.dart';
//
// class AgoraService {
//   static const String appId = 'YOUR_AGORA_APP_ID';
//   RtcEngine? _engine;
//
//   Future<void> initialize() async {
//     _engine = await RtcEngine.create(appId);
//     await _engine?.enableVideo();
//   }
//
//   Future<void> joinChannel(String token, String channelName, int uid) async {
//     await _engine?.joinChannel(token, channelName, null, uid);
//   }
//
//   Future<void> leaveChannel() async {
//     await _engine?.leaveChannel();
//   }
//
//   void setEventHandlers(RtcEngineEventHandler handler) {
//     _engine?.setEventHandler(handler);
//   }
// }
