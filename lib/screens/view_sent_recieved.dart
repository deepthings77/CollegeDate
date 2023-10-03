import 'package:flutter/material.dart';

class ViewSentRecieved extends StatefulWidget {
  const ViewSentRecieved({super.key});

  @override
  State<ViewSentRecieved> createState() => _ViewSentRecievedState();
}

class _ViewSentRecievedState extends State<ViewSentRecieved> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("ViewSentRecieved",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 30
        ),),
        
      ),
    );
  }
}