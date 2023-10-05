import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegedate/global.dart';

import 'package:flutter/material.dart';

class LikeSendreceieved extends StatefulWidget {
  const LikeSendreceieved({super.key});

  @override
  State<LikeSendreceieved> createState() => _LikeSendreceievedState();
}

class _LikeSendreceievedState extends State<LikeSendreceieved> {
  bool isLikeClicked = true;
  List<String> likeSentList = [];
  List<String> likeRecievedList = [];
  List likeList = [];

  getLikedListKey() async {
    if (isLikeClicked) {
      var favouriteSentDocument = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId.toString())
          .collection("likeSent")
          .get();

      for (int i = 0; i < favouriteSentDocument.docs.length; i++) {
        likeSentList.add(favouriteSentDocument.docs[i].id);
      }
       print("likeSentList= " + likeSentList.toString());
      getKeysDataFromCollection(likeSentList);
    } else {
      var favouriteRecievedDocument = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId.toString())
          .collection("likeRecieved")
          .get();

      for (int i = 0; i < favouriteRecievedDocument.docs.length; i++) {
        likeRecievedList.add(favouriteRecievedDocument.docs[i].id);
      }

      print("likeRecievedList= " + likeRecievedList.toString());
      getKeysDataFromCollection(likeRecievedList);
    }
  }

  getKeysDataFromCollection(List<String> keysList) async {
    var allUserDocument =
        await FirebaseFirestore.instance.collection('users').get();

    for (int i = 0; i < allUserDocument.docs.length; i++) {
      for (int k = 0; k < keysList.length; k++) {
        if (((allUserDocument.docs[i].data() as dynamic)["uid"]) ==
            keysList[k]) {
          likeList.add(allUserDocument.docs[i].data());
        }
      }
    }
    setState(() {
      likeList;
    });
    print("likeList= " + likeList.toString());
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getLikedListKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    likeSentList.clear();
                    likeSentList = [];
                    likeRecievedList.clear();

                    likeRecievedList = [];
                    likeList.clear();
                    likeList = [];

                    setState(() {
                      isLikeClicked = true;
                    });

                    getLikedListKey();
                  },
                  child: Text(
                    "My Likes",
                    style: TextStyle(
                        color: isLikeClicked ? Colors.white : Colors.grey,
                        fontWeight: isLikeClicked
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 14),
                  )),
              const Text(
                "  |  ",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              TextButton(
                  onPressed: () {
                    likeSentList.clear();
                    likeSentList = [];
                    likeRecievedList.clear();

                    likeRecievedList = [];
                    likeList.clear();
                    likeList = [];

                    setState(() {
                      isLikeClicked = false;
                    });

                    getLikedListKey();
                  },
                  child: Text(
                    "Liked my profile",
                    style: TextStyle(
                        color: isLikeClicked ? Colors.grey : Colors.white,
                        fontWeight: isLikeClicked
                            ? FontWeight.normal
                            : FontWeight.bold,
                        fontSize: 14),
                  )),
            ],
          ),
          centerTitle: true,
        ),
        body: likeList.isEmpty
            ? const Center(
                child: Icon(
                  Icons.not_interested_rounded,
                  color: Colors.white,
                  size: 60,
                ),
              )
            : GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(8),
                children: List.generate(likeList.length, (index) {
                  return GridTile(
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Card(
                        color: Colors.blue.shade200,
                        child: GestureDetector(
                          onTap: () {},
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        likeList[index]["imageProfile"]),
                                    fit: BoxFit.cover),
                              ),
                              child:  Padding(
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Spacer(),
                                      Expanded(
                                        child: Text(
                                          likeList[index]["name"]
                                                  .toString() +
                                              "  #  " +
                                              likeList[index]["age"]
                                                  .toString(),
                                          style:  TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      // Expanded(
                                      //   child: Text(
                                      //     favouriteList[index]["city"]
                                      //             .toString() +
                                      //         "  #  " +
                                      //         favouriteList[index]["state"]
                                      //             .toString(),
                                      //             maxLines: 2,
                                      //     style: TextStyle(
                                            
                                      //       overflow: TextOverflow.ellipsis,
                                      //       color: Colors.white,
                                      //       fontSize: 16,
                                      //       fontWeight: FontWeight.bold,
                                      //     ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                ),
                              )),
                        ),
                      ),
                    ),
                  );
                }),
              ));
  }
}
