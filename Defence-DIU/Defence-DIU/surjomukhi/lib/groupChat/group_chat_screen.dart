import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calculate_time.dart';
import 'firebase_service.dart';

class GroupChatScreen extends StatefulWidget {
  final String groupName;

  GroupChatScreen({required this.groupName});

  @override
  _GroupChatScreenState createState() => _GroupChatScreenState();
}

class _GroupChatScreenState extends State<GroupChatScreen> {
  String _currentUserId = ''; // Add this line to declare the variable
  final FirebaseService firebaseService = FirebaseService();
  final TextEditingController messageController = TextEditingController();

  String currentUserId = '';
  late Stream<QuerySnapshot> messagesStream;
  late Stream<Map<String, String>> usersStream;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _getCurrentUser();
    getUsersStream();
  }

  void getCurrentUser() {
    currentUserId = firebaseService.getCurrentUserId();
    messagesStream = firebaseService.getGroupMessagesStream(widget.groupName);
  }

  void getUsersStream() {
    // Get a stream of user data for all users in the group
    usersStream = firebaseService.getUsersStreamInGroup(widget.groupName);
  }

  void sendMessage() {
    String message = messageController.text.trim();
    if (message.isNotEmpty) {
      firebaseService.sendMessage(widget.groupName, message, currentUserId);
      messageController.clear();
    }
  }

  void _getCurrentUser() async {
    // Get the current user's ID from FirebaseAuth
    await FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        setState(() {
          _currentUserId = user.uid;
        });
      }
    });
  }

  Widget _buildMessageTile(
      String text, String senderId, final isMe, String timeOfMessage) {
    return FutureBuilder<String>(
      future: firebaseService.getNameFromFirestore(senderId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('');
        }

        String senderName = snapshot.data ?? 'Unknown User';

        // Display the message with the user's name
        return Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                timeOfMessage,
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Align(
              alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 300,
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                padding: EdgeInsets.symmetric(vertical: 1, horizontal: 1),
                decoration: BoxDecoration(
                  color: isMe ? Color(0xfffae4cb) : Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ListTile(
                  title: Text(
                    text,
                    style: GoogleFonts.poppins(),
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        'Sent by: $senderName',
                        style: GoogleFonts.poppins(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );

        // ListTile(
        //   title: Text(text),
        //   subtitle: Text('Sent by: $senderName'),
        // );
      },
    );
  }

  Widget _buildMessageInput(
      final TextEditingController _messageController, _sendMessage) {
    return Container(
      color: const Color.fromARGB(255, 232, 231,
          231), // Off-white background color for the outer container
      padding: EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors
                  .white, // White background color for the inner container
              borderRadius: BorderRadius.circular(
                  20.0), // Rounded corners for the TextField container
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 14.0),
                      border:
                          InputBorder.none, // Hide the default underline border
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  color: Colors.blue,
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              color: Color.fromARGB(
                  255, 248, 250, 250), // Background color of AppBar
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.0), // Rounded bottom corners
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    // Add logic to handle back navigation if needed
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 8.0),
                Text(
                  widget.groupName,
                  style: GoogleFonts.openSans(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                Spacer(), // Adds flexible space between title and actions
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: messagesStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}',
                        style: GoogleFonts.poppins()),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<QueryDocumentSnapshot> messages = snapshot.data!.docs;
                return ListView.builder(
                  reverse: true,
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    String message = messages[index]['text'];
                    String senderId = messages[index]['senderId'];
                    final timestamp = messages[index]['timestamp'];
                    // Implement UI to display messages with sender information
                    // Check if the message sender is the current user
                    final isMe = (senderId == _currentUserId);
// Calculate the time of the current message
                    String timeOfMessage =
                        calculateTimeOfMessage(index, messages, timestamp);

                    return _buildMessageTile(
                        message, senderId, isMe, timeOfMessage);
                  },
                );
              },
            ),
          ),
          _buildMessageInput(
            messageController,
            sendMessage,
          ),
        ],
      ),
    );
  }
}
