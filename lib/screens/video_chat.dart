import 'package:flutter/material.dart';

class VideoChatScreen extends StatefulWidget {
  const VideoChatScreen({super.key});

  @override
  State<VideoChatScreen> createState() => _VideoChatScreenState();
}

class _VideoChatScreenState extends State<VideoChatScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Coming Soon.......",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 30
        ),),
        
      ),
    );
  }
}