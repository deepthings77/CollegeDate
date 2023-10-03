
import 'package:flutter/material.dart';

class FavouriteSendreceieved extends StatefulWidget {
  const FavouriteSendreceieved({super.key});

  @override
  State<FavouriteSendreceieved> createState() => _FavouriteSendreceievedState();
}

class _FavouriteSendreceievedState extends State<FavouriteSendreceieved> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Favouirite Send Reciecved Screen",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 30
        ),),
        
      ),
    );
  }
}