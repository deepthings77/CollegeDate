
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegedate/global.dart';
import 'package:collegedate/homeScreen/home_screen.dart';
import 'package:collegedate/widgets/custom_text_field_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AccountSettingScreen extends StatefulWidget {
  const AccountSettingScreen({super.key});

  @override
  State<AccountSettingScreen> createState() => _AccountSettingScreenState();
}

class _AccountSettingScreenState extends State<AccountSettingScreen> {
  bool uploading = false, next = false;
  final List<File> _images = [];
  List<String> urlList = [];
  double val = 0;

  TextEditingController emailtexteditingController = TextEditingController();
  TextEditingController passwordtexteditingController = TextEditingController();
  TextEditingController nametexteditingController = TextEditingController();
  TextEditingController agetexteditingController = TextEditingController();
  TextEditingController citytexteditingController = TextEditingController();
  TextEditingController statetexteditingController = TextEditingController();
  TextEditingController phonenotexteditingController = TextEditingController();
  TextEditingController profileheadingtexteditingController =
      TextEditingController();

  String name = '';
  String age = '';
  String phoneNo = '';
  String city = '';
  String state = '';
  String profileHeading = '';

  chooseImage() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _images.add(File(pickedFile!.path));
    });
  }

  uploadImages() async {
    int i = 1;
    for (var img in _images) {
      setState(() {
        val = i / _images.length;
      });

      var refImages = FirebaseStorage.instance.ref().child(
          "images/${DateTime.now().millisecondsSinceEpoch.toString()}.jpg");

      await refImages.putFile(img).whenComplete(() async {
        await refImages.getDownloadURL().then((urlImage) {
          urlList.add(urlImage);
          i++;
        });
      });
    }
  }

  retrieveUserData() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(currentUserId)
        .get()
        .then((snapshot) {
      if (snapshot.exists) {
        setState(() {
          name = snapshot.data()!["name"];
          nametexteditingController.text = name;
          age = snapshot.data()!["age"];
          agetexteditingController.text = age.toString();
          phoneNo = snapshot.data()!["phoneNo"];
          phonenotexteditingController.text = phoneNo;
          city = snapshot.data()!["city"];
          citytexteditingController.text = city;
          state = snapshot.data()!["state"];
          statetexteditingController.text = state;
          profileHeading = snapshot.data()!["profileHeading"];
          profileheadingtexteditingController.text = profileHeading;
        });
      }
    });
  }

  updateUserDatatoFirestoreDatabase(
    String name,
    String age,
    String city,
    String state,
    String phoneNo,
    String profileheading,
  ) async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
              child: Column(
            children: [
              CircularProgressIndicator(),
              SizedBox(
                height: 10,
              ),
              Text("Uploading Images...")
            ],
          ));
        });
    await uploadImages();

  await  FirebaseFirestore.instance.collection("users").doc(currentUserId).update({
      "name": name,
      "age": int.parse(age),
      "city": city,
      "state": state,
      "phoneNo": phoneNo,
      "profileheading": profileheading,

      "urlImage1" : urlList[0].toString(),
      "urlImage2" : urlList[2].toString(),
      "urlImage3" : urlList[3].toString(),
    });


    Get.snackbar("Updated", "Account Successfully updated");
    Get.to(const HomeScreen());

    setState(() {
       uploading = false;
       _images.clear();
       urlList.clear();
       
      
    });

   
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          next ? "Profile Information" : "Choose Images",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        actions: [
          next
              ? Container()
              : IconButton(
                  onPressed: () {

                    if(_images.length == 3){

                      setState(() {
                        uploading = true;
                        next = true;
                      });

                    } else{
                     Get.snackbar("3 Images Needed","Please Upload images");
                    }
                  },
                  icon: const Icon(
                    Icons.navigate_next_outlined,
                    size: 36,
                  ))
        ],
      ),
      body: next
          ? SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Information",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 36,
                      child: CustomTextField(
                        editingController: nametexteditingController,
                        labelText: "Name",
                        iconData: Icons.person_2_outlined,
                        isobscure: false,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 36,
                      child: CustomTextField(
                        editingController: agetexteditingController,
                        labelText: "Age",
                        iconData: Icons.numbers,
                        isobscure: false,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 36,
                      child: CustomTextField(
                        editingController: citytexteditingController,
                        labelText: "City",
                        iconData: Icons.location_city,
                        isobscure: false,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 36,
                      child: CustomTextField(
                        editingController: statetexteditingController,
                        labelText: "State",
                        iconData: Icons.location_city,
                        isobscure: false,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 36,
                      child: CustomTextField(
                        editingController: phonenotexteditingController,
                        labelText: "phone no",
                        iconData: Icons.phone,
                        isobscure: false,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 36,
                      child: CustomTextField(
                        editingController: profileheadingtexteditingController,
                        labelText: "ProfileHeading",
                        iconData: Icons.text_fields,
                        isobscure: false,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width - 136,
                      height: 35,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: InkWell(
                        onTap: () async {
                          if (nametexteditingController.text.trim().isNotEmpty &&
                              phonenotexteditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              citytexteditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              statetexteditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              profileheadingtexteditingController.text
                                  .trim()
                                  .isNotEmpty &&
                              agetexteditingController.text.trim().isNotEmpty) {

                                _images.length > 0 ? 
                            await updateUserDatatoFirestoreDatabase(
                                nametexteditingController.text.trim(),
                                agetexteditingController.text.trim(),
                                citytexteditingController.text.trim(),
                                statetexteditingController.text.trim(),
                                phonenotexteditingController.text.trim(),
                                profileheadingtexteditingController.text
                                    .trim()) : null ;
                          } else {
                            Get.snackbar(
                                "Field Missing", "Please Fill all the Fields");
                          }
                        },
                        child: const AlertDialog(
                          content: SizedBox(
                            child:  Center(
                            child: Text(
                              "Update Account",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ) 
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                  ],
                ),
              ),
            )
          : Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3),
                    itemCount: _images.length + 1,
                    itemBuilder: (context, index) {
                      return index == 0
                          ? Container(
                              color: Colors.white30,
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    if(_images.length < 3){
                                            !uploading ? chooseImage() : null;
                                    } else{
                                      setState(() {
                                        uploading == true;
                                      });
                                      Get.snackbar('3 Images ', '3 Images already selected');
                                    }
                                    
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                              ),
                            )
                          : Container(
                              margin: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: FileImage(_images[index - 1]),
                                      fit: BoxFit.cover)),
                            );
                    },
                  ),
                )
              ],
            ),
    );
  }
}
