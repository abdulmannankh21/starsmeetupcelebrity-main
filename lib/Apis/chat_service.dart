import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

import '../models/message_model.dart';

class ChatService {
  final String meetingId;

  ChatService(this.meetingId);

  final CollectionReference _messageCollection =
      FirebaseFirestore.instance.collection('chatRooms');

  Stream<List<Message>> getAllMessages() {
    final fanMessagesStream = _messageCollection
        .doc(meetingId)
        .collection('messages')
        .doc('fanMessages')
        .collection('fanMessages')
        .orderBy('timestamp')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Message(
                    sender: doc['sender'],
                    content: doc['content'],
                    timestamp: (doc['timestamp'] as Timestamp).toDate(),
                    senderUid: doc['senderUid'],
                  ))
              .toList(),
        );

    final startMessagesStream = _messageCollection
        .doc(meetingId)
        .collection('messages')
        .doc('starMessages')
        .collection('starMessages')
        .orderBy('timestamp')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Message(
                    sender: doc['sender'],
                    content: doc['content'],
                    timestamp: (doc['timestamp'] as Timestamp).toDate(),
                    senderUid: doc['senderUid'],
                  ))
              .toList(),
        );

    // Merge the streams of fanMessages and startMessages into a single stream
    final mergedStream =
        Rx.combineLatest2<List<Message>, List<Message>, List<Message>>(
      fanMessagesStream,
      startMessagesStream,
      (fanMessages, startMessages) => [...fanMessages, ...startMessages],
    );

    // Sort the combined list of messages based on the message timestamps
    return mergedStream.map((messages) {
      messages.sort((a, b) => a.timestamp!.compareTo(b.timestamp!));
      return messages;
    });
  }

  Future<void> sendMessage(String sender, String content, bool isFanMessage,
      String senderUid) async {
    print("sending");
    try {
      final CollectionReference messagesCollection =
          _messageCollection.doc(meetingId).collection('messages');
      final CollectionReference subCollection = isFanMessage
          ? messagesCollection.doc('fanMessages').collection('fanMessages')
          : messagesCollection.doc('starMessages').collection('starMessages');

      await subCollection.add({
        'sender': sender,
        'content': content,
        'timestamp': DateTime.now(),
        'senderUid': senderUid
      });
    } catch (e) {
      print("Error sending message: $e");
    }
  }
}
