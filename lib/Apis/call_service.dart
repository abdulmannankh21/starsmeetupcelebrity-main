import 'package:cloud_firestore/cloud_firestore.dart';

class CallService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> initiateCall(String receiverId, String channelName) async {
    final callData = {
      'receiver_id': receiverId,
      'channel_name': channelName,
      'timestamp': Timestamp.now(),
    };

    await _firestore.collection('calls').add(callData);
  }
}
