import 'package:flutter/material.dart';

class LikeSendRecievedScreen extends StatefulWidget {
  const LikeSendRecievedScreen({super.key});

  @override
  State<LikeSendRecievedScreen> createState() => _LikeSendRecievedScreenState();
}

class _LikeSendRecievedScreenState extends State<LikeSendRecievedScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Like",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 30
        ),),
        
      ),
    );
  }
}