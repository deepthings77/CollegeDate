import 'dart:io';

import 'package:collegedate/controllers/authentication_controllers.dart';
import 'package:collegedate/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController emailtexteditingController = TextEditingController();
  TextEditingController passwordtexteditingController = TextEditingController();
  TextEditingController nametexteditingController = TextEditingController();
  TextEditingController agetexteditingController = TextEditingController();
  TextEditingController citytexteditingController = TextEditingController();
  TextEditingController statetexteditingController = TextEditingController();
  TextEditingController phonenotexteditingController = TextEditingController();
  TextEditingController profileheadingtexteditingController =
      TextEditingController();
  bool showProgressBar = false;
  var authenticationController = AuthenticationController.authController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              authenticationController.imageFile == null
                  ? const CircleAvatar(
                      backgroundColor: Colors.black,
                      backgroundImage: AssetImage("images/download.png"),
                      radius: 80,
                    )
                  : Container(
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey,
                          image: DecorationImage(
                              fit: BoxFit.fitHeight,
                              image: FileImage(File(
                                  authenticationController.imageFile!.path)))),
                    ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () async {
                        await authenticationController
                            .pickImageFileFromGallery();

                        setState(() {
                          authenticationController.imageFile;
                        });
                      },
                      icon: const Icon(
                        Icons.image,
                        color: Colors.grey,
                      )),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                      onPressed: () async {
                        await authenticationController.captureImageFromCamera();
                        setState(() {
                          authenticationController.imageFile;
                        });
                      },
                      icon: const Icon(
                        Icons.camera,
                        color: Colors.grey,
                      ))
                ],
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
                  editingController: emailtexteditingController,
                  labelText: "Email",
                  iconData: Icons.email_outlined,
                  isobscure: false,
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 36,
                child: CustomTextField(
                  editingController: passwordtexteditingController,
                  labelText: "Password",
                  iconData: Icons.lock_outlined,
                  isobscure: true,
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
              //create account button
              Container(
                width: MediaQuery.of(context).size.width - 136,
                height: 35,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: InkWell(
                  onTap: () async{
                    if (authenticationController.imageFile!= null) {
                      if (nametexteditingController.text.trim().isNotEmpty &&
                          emailtexteditingController.text.trim().isNotEmpty &&
                          passwordtexteditingController.text
                              .trim()
                              .isNotEmpty &&
                          phonenotexteditingController.text.trim().isNotEmpty &&
                          citytexteditingController.text.trim().isNotEmpty &&
                          statetexteditingController.text.trim().isNotEmpty &&
                          profileheadingtexteditingController.text
                              .trim()
                              .isNotEmpty &&
                            agetexteditingController.text.trim().isNotEmpty) {

                              setState(() {
                                showProgressBar = true;
                              });



                      await authenticationController.createNewUserAccount(
                            authenticationController.profileImage!,
                            emailtexteditingController.text.trim(),
                            passwordtexteditingController.text.trim(),
                            nametexteditingController.text.trim(),
                            agetexteditingController.text.trim(),
                            citytexteditingController.text.trim(),
                            statetexteditingController.text.trim(),
                            phonenotexteditingController.text.trim(),
                            profileheadingtexteditingController.text.trim());

                            setState(() {
                              showProgressBar =   false;
                              authenticationController.imageFile = null;
                            });
                            
                      } else {
                        Get.snackbar(
                            "Field Missing", "Please Fill all the Fields");
                      }
                    } else {
                      Get.snackbar(
                          "Image Missing", "Please Choose a Profile picture");
                    }
                  },
                  child: const Center(
                    child: Text(
                        "Create Account",
                        style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an Account?",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Text(
                      "Click here",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(
                height: 25,
              ),

              showProgressBar == true
                  ? const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
