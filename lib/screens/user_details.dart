
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {


  @override
  Widget build(BuildContext context) {



    return  Scaffold(
      appBar: AppBar(
        title: Text(
          "User Profile",
          style: TextStyle(
            color: Colors.white,
          
          ),
          
          
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            
          }, icon: Icon(Icons.logout,
          size: 30,))
        ],
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Text("User Details ",
        style: TextStyle(
          color: Colors.blue,
          fontSize: 30
        ),),
        
      ),
    );
  }
}