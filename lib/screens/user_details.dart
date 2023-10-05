import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slider/carousel.dart';

class UserDetailsScreen extends StatefulWidget {
  String? userId;
  UserDetailsScreen({super.key, this.userId});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  String name = '';
  String age = '';
  String phoneNo = '';
  String city = '';
  String state = '';
  String? profileHeading = '';

  String urlImage1 =
      'https://firebasestorage.googleapis.com/v0/b/collegedate-e671e.appspot.com/o/Place%20holder%2Fuser.png?alt=media&token=6ca7fc04-9044-477d-b481-1ca444bb0e36';
  String urlImage2 =
      'https://firebasestorage.googleapis.com/v0/b/collegedate-e671e.appspot.com/o/Place%20holder%2Fuser.png?alt=media&token=6ca7fc04-9044-477d-b481-1ca444bb0e36';
  String urlImage3 =
      'https://firebasestorage.googleapis.com/v0/b/collegedate-e671e.appspot.com/o/Place%20holder%2Fuser.png?alt=media&token=6ca7fc04-9044-477d-b481-1ca444bb0e36';
  //String urlImage4 = 'https://firebasestorage.googleapis.com/v0/b/collegedate-e671e.appspot.com/o/Place%20holder%2Fuser.png?alt=media&token=6ca7fc04-9044-477d-b481-1ca444bb0e36';
  //String urlImage5 = 'https://firebasestorage.googleapis.com/v0/b/collegedate-e671e.appspot.com/o/Place%20holder%2Fuser.png?alt=media&token=6ca7fc04-9044-477d-b481-1ca444bb0e36';

  retrieveUserInfo() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userId)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        if (snapshot.data()!["urlImage1"] != null) {
          setState(() {
            urlImage1 = snapshot.data()!["urlImage1"];
            urlImage2 = snapshot.data()!["urlImage2"];
            urlImage3 = snapshot.data()!["urlImage3"];
            // urlImage4 =  snapshot.data()!["urlImage4"];
            // urlImage5 =  snapshot.data()!["urlImage5"];
          });
        }

        setState(() {
          name = snapshot.data()!["name"];
          age = snapshot.data()!["age"].toString();
          phoneNo = snapshot.data()!["phoneNo"];
          city = snapshot.data()!["city"];
          state = snapshot.data()!["state"];
          profileHeading = snapshot.data()!["profileHeading"];
        });
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    retrieveUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            name.toUpperCase(),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                },
                icon: Icon(
                  Icons.logout,
                  size: 30,
                ))
          ],
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(2),
                    child: Carousel(
                      indicatorBarColor: Colors.black.withOpacity(0.3),
                      autoScrollDuration: const Duration(seconds: 3),
                      animationPageCurve: Curves.easeIn,
                      animationPageDuration: const Duration(milliseconds: 500),
                      activateIndicatorColor: Colors.black,
                      indicatorBarHeight: 30,
                      indicatorHeight: 10,
                      indicatorWidth: 10,
                      unActivatedIndicatorColor: Colors.grey,
                      stopAtEnd: false,
                      autoScroll: true,
                      items: [
                        Image.network(
                          urlImage1,
                          fit: BoxFit.contain,
                        ),
                        Image.network(
                          urlImage2,
                          fit: BoxFit.contain,
                        ),
                        Image.network(
                          urlImage3,
                          fit: BoxFit.contain,
                        ),
                        //Image.network(urlImage4, fit: BoxFit.contain,),
                        //Image.network(urlImage5, fit: BoxFit.contain,),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Profile Info : ",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  thickness: 2,
                ),
                Container(
                  color: Colors.black,
                  padding: const EdgeInsets.all(20),
                  child: Table(
                    children: [
                      TableRow(children: [
                        const Text(
                          "Name: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          name,
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        )
                      ]),
                      const TableRow(children: [
                        Text(""),
                        Text(""),
                      ]),
                      TableRow(children: [
                        const Text(
                          "Age: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          age,
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        )
                      ]),
                      const TableRow(children: [
                        Text(""),
                        Text(""),
                      ]),
                      TableRow(children: [
                        const Text(
                          "PhoneNo: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          phoneNo,
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        )
                      ]),
                      const TableRow(children: [
                        Text(""),
                        Text(""),
                      ]),
                      TableRow(children: [
                        const Text(
                          "City: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          city,
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        )
                      ]),
                      const TableRow(children: [
                        Text(""),
                        Text(""),
                      ]),
                      TableRow(children: [
                        const Text(
                          "State: ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          state,
                          style: TextStyle(color: Colors.grey, fontSize: 18),
                        )
                      ]),
                      const TableRow(children: [
                        Text(""),
                        Text(""),
                      ]),
                      // TableRow(children: [
                      //   const Text(
                      //     "Profile Heading: ",
                      //     style: TextStyle(
                      //       color: Colors.white,
                      //       fontSize: 18,
                      //     ),
                      //   ),
                      //   Text(
                      //     profileHeading!,
                      //     style: TextStyle(color: Colors.grey, fontSize: 18),
                      //   )
                      // ]),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
