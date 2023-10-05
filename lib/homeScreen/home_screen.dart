import 'package:collegedate/screens/favourite_sent_recieved.dart';
import 'package:collegedate/screens/like_send_recieved_screen.dart';
import 'package:collegedate/screens/swipping_screen.dart';
import 'package:collegedate/screens/user_details.dart';
import 'package:collegedate/screens/video_chat.dart';
import 'package:collegedate/screens/view_sent_recieved.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int screenIndex = 0;

  List tabScreens = [
    SwippingScreen(),
    ViewSentRecieved(),
    FavouriteSendreceieved(),
    LikeSendRecievedScreen(),
    UserDetailsScreen( userId: FirebaseAuth.instance.currentUser!.uid,),
    VideoChatScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (indexNumber) {

          setState(() {
            screenIndex = indexNumber;
          });

        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white38,
        currentIndex: screenIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 30,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.remove_red_eye_outlined,
              size: 30,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.star,
              size: 30,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              size: 30,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              size: 30,
            ),
            label: "",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.video_camera_front_outlined,
              size: 30,
            ),
            label: "",
          ),
        ],
      ),
      body: tabScreens[screenIndex]
    );
  }
}
