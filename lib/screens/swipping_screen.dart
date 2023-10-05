import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegedate/controllers/profile_controller.dart';
import 'package:collegedate/global.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwippingScreen extends StatefulWidget {
  const SwippingScreen({super.key});

  @override
  State<SwippingScreen> createState() => _SwippingScreenState();
}

class _SwippingScreenState extends State<SwippingScreen> {
  ProfileController profileController = Get.put(ProfileController());
 late String senderName;

  readCurrentUserData() async {

    await FirebaseFirestore.instance.collection("users").doc(currentUserId).get().then((dataSnapshot) {
      setState(() {
        senderName = dataSnapshot.data()!["name"].toString();
      });
    });

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Obx(
      () {
        return PageView.builder(
          itemCount: profileController.allUsersProfileList.length,
          controller: PageController(initialPage: 0, viewportFraction: 1),
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final eachProfileInfo =
                profileController.allUsersProfileList[index];

            return DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image:
                        NetworkImage(eachProfileInfo.imageProfile.toString()),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.filter_list,
                              size: 50,
                            )),
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {},
                      child: Column(
                        children: [
                          Text(
                            eachProfileInfo.name.toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                letterSpacing: 4,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            eachProfileInfo.age.toString() +
                                " 📍 " +
                                eachProfileInfo.state.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              letterSpacing: 4,
                            ),
                          ),
                          Text(
                            eachProfileInfo.email.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              letterSpacing: 3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () {

                            profileController.favouriteSendFavouritereceieved(eachProfileInfo.uid.toString(), senderName);



                          },
                          child: Image.asset(
                            "images/star.png",
                            width: 60,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            "images/lover.png",
                            width: 60,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Image.asset(
                            "images/speak.png",
                            width: 60,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    ));
  }
}
