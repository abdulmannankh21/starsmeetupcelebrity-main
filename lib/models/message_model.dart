class Message {
  final String sender;
  final String content;
  final String senderUid;
  final DateTime timestamp;

  Message({
    required this.sender,
    required this.content,
    required this.timestamp,
    required this.senderUid,
  });
}
