import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:starsmeetupcelebrity/call/videoCall.dart';

import '../../Apis/chat_service.dart';
import '../../Utilities/app_colors.dart';
import '../../Utilities/app_text_styles.dart';
import '../../models/appointment_model.dart';
import '../../models/message_model.dart';

class ChatPage extends StatefulWidget {
  final AppointmentModel? appointment;
  final String meetingId;

  const ChatPage({Key? key, required this.meetingId, this.appointment})
      : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  late final ChatService _chatService;
  late final FirebaseAuth _auth;
  String _userName = '';
  late AppointmentModel _appointment;

  @override
  void initState() {
    super.initState();
    print(widget.meetingId);
    _chatService = ChatService(widget.meetingId);
    _auth = FirebaseAuth.instance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: whiteColor,
        backgroundColor: purpleColor,
        title: Text(
          widget.appointment!.userName!,
          style: eighteen700TextStyle(color: whiteColor),
        ),
        actions: [
          (widget.appointment!.serviceName == "Audio Meeting")
              ? IconButton(
                  icon: Icon(Icons.phone),
                  onPressed: () {
                    // Implement audio call action
                  },
                )
              : SizedBox.shrink(),
          (widget.appointment!.serviceName == "Video Meeting")
              ? IconButton(
                  icon: Icon(Icons.videocam),
                  onPressed: () async {
                    // Implement video call action

                    User? user = await FirebaseAuth.instance.currentUser;
                    print("this is user " + user!.email!);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AgoraCalls(
                                  channelName: user.email!,
                                )));
                  },
                )
              : SizedBox.shrink(),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List<Message>>(
              stream: _chatService.getAllMessages(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final messages = snapshot.data!;
                print(messages.length);
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    return _buildMessageWidget(message);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _sendMessage();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageWidget(Message message) {
    final bool isCurrentUser = message.senderUid == _auth.currentUser!.email;
    return Column(
      crossAxisAlignment:
          isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
          alignment:
              isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: isCurrentUser ? purpleColor : Colors.grey[300],
            ),
            child: Text(
              message.content,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: isCurrentUser ? whiteColor : Colors.black,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            '${message.timestamp.hour}:${message.timestamp.minute}',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isNotEmpty) {
      _chatService.sendMessage(widget.appointment!.celebrityName!, message,
          false, _auth.currentUser!.email!);
      _messageController.clear();
    }
  }
}
