import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegedate/global.dart';

import 'package:flutter/material.dart';

class FavouriteSendreceieved extends StatefulWidget {
  const FavouriteSendreceieved({super.key});

  @override
  State<FavouriteSendreceieved> createState() => _FavouriteSendreceievedState();
}

class _FavouriteSendreceievedState extends State<FavouriteSendreceieved> {
  bool isFavouriteClicked = true;
  List<String> favouriteSentList = [];
  List<String> favouriteRecievedList = [];
  List favouriteList = [];

  getfavouriteListKey() async {
    if (isFavouriteClicked) {
      var favouriteSentDocument = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId.toString())
          .collection("favouriteSent")
          .get();

      for (int i = 0; i < favouriteSentDocument.docs.length; i++) {
        favouriteSentList.add(favouriteSentDocument.docs[i].id);
      }
       print("favouriteSentList List= " + favouriteSentList.toString());
      getKeysDataFromCollection(favouriteSentList);
    } else {
      var favouriteRecievedDocument = await FirebaseFirestore.instance
          .collection('users')
          .doc(currentUserId.toString())
          .collection("favouriteRecieved")
          .get();

      for (int i = 0; i < favouriteRecievedDocument.docs.length; i++) {
        favouriteRecievedList.add(favouriteRecievedDocument.docs[i].id);
      }

      print("favouriteRecievedList List= " + favouriteRecievedList.toString());
      getKeysDataFromCollection(favouriteRecievedList);
    }
  }

  getKeysDataFromCollection(List<String> keysList) async {
    var allUserDocument =
        await FirebaseFirestore.instance.collection('users').get();

    for (int i = 0; i < allUserDocument.docs.length; i++) {
      for (int k = 0; k < keysList.length; k++) {
        if (((allUserDocument.docs[i].data() as dynamic)["uid"]) ==
            keysList[k]) {
          favouriteList.add(allUserDocument.docs[i].data());
        }
      }
    }
    setState(() {
      favouriteList;
    });
    print("favourite List= " + favouriteList.toString());
  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getfavouriteListKey();
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
                    favouriteSentList.clear();
                    favouriteSentList = [];
                    favouriteRecievedList.clear();

                    favouriteRecievedList = [];
                    favouriteList.clear();
                    favouriteList = [];

                    setState(() {
                      isFavouriteClicked = true;
                    });

                    getfavouriteListKey();
                  },
                  child: Text(
                    "My Favourites",
                    style: TextStyle(
                        color: isFavouriteClicked ? Colors.white : Colors.grey,
                        fontWeight: isFavouriteClicked
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
                    favouriteSentList.clear();
                    favouriteSentList = [];
                    favouriteRecievedList.clear();

                    favouriteRecievedList = [];
                    favouriteList.clear();
                    favouriteList = [];

                    setState(() {
                      isFavouriteClicked = false;
                    });

                    getfavouriteListKey();
                  },
                  child: Text(
                    "I'm their favourite",
                    style: TextStyle(
                        color: isFavouriteClicked ? Colors.grey : Colors.white,
                        fontWeight: isFavouriteClicked
                            ? FontWeight.normal
                            : FontWeight.bold,
                        fontSize: 14),
                  )),
            ],
          ),
          centerTitle: true,
        ),
        body: favouriteList.isEmpty
            ? const Center(
                child: Icon(
                  Icons.person_off_sharp,
                  color: Colors.white,
                  size: 60,
                ),
              )
            : GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(8),
                children: List.generate(favouriteList.length, (index) {
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
                                        favouriteList[index]["imageProfile"]),
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
                                          favouriteList[index]["name"]
                                                  .toString() +
                                              "  #  " +
                                              favouriteList[index]["age"]
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
