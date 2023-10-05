import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegedate/global.dart';
import 'package:collegedate/models/person.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  final Rx<List<Person>> userProfileList = Rx<List<Person>>([]);
  List<Person> get allUsersProfileList => userProfileList.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    userProfileList.bindStream(FirebaseFirestore.instance
        .collection("users")
        .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .map((QuerySnapshot quaryDataSnapshot) {
      List<Person> profileList = [];
      for (var eachProfile in quaryDataSnapshot.docs) {
        profileList.add(Person.fromDataSnapshot(eachProfile));
      }
      return profileList;
    }));
  }

  favouriteSendFavouritereceieved(String toUserId, String senderName) async {
    var document = await FirebaseFirestore.instance
        .collection("users")
        .doc(toUserId)
        .collection('favouriteRecieved')
        .doc(currentUserId)
        .get();
//if favorite already exist
    if (document.exists) {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserId)
          .collection('favouriteRecieved')
          .doc(currentUserId)
          .delete();

      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId)
          .collection('favouriteSent')
          .doc(currentUserId)
          .get();
    } else {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(toUserId)
          .collection('favouriteRecieved')
          .doc(currentUserId)
          .set({});

      await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUserId)
          .collection('favouriteSent')
          .doc(currentUserId)
          .set({});
    }
  }
}
