import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collegedate/homeScreen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:collegedate/models/person.dart' as personModel;

class AuthenticationController extends GetxController{

    static AuthenticationController authController = Get.find();

    late Rx<File?> pickedfile;
    File? get profileImage => pickedfile.value;
    XFile? imageFile;

    pickImageFileFromGallery() async{

      imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);

      if(imageFile != null){
          Get.snackbar("Profile Image"," You have successfully picked your profile image");
      }
      pickedfile =  Rx<File?>(File(imageFile!.path)); 

    }
    captureImageFromCamera() async{

       imageFile = await ImagePicker().pickImage(source: ImageSource.camera);

      if(imageFile != null){
          Get.snackbar("Profile Image"," You have successfully captured  your profile image");
      }
      pickedfile =  Rx<File?>(File(imageFile!.path)); 

    }

    Future<String> uploadImageToStorage(File imageFile) async{

      Reference referenceStorage = FirebaseStorage.instance.ref().child("Profile Images").child(FirebaseAuth.instance.currentUser!.uid);
      
      UploadTask task = referenceStorage.putFile(imageFile);
      TaskSnapshot snapshot = await task;

      String downloadUrlOfImage = await snapshot.ref.getDownloadURL();

      return downloadUrlOfImage;


    }


    createNewUserAccount(
      File imageProfile,
      String email,
      String password,
  String name,
  String age,
  String city,
  String state,
  String phoneNo,
  String profileheading,
  
    ) async{

      try{
        //authenticate user
      UserCredential credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        //upload photo to firebase
      String urlOfDownlodedImage =   await   uploadImageToStorage(imageProfile);

        //save user info to firestore database
      personModel.Person personInstance = await personModel.Person(
        imageProfile: urlOfDownlodedImage,
        email: email,
        password: password,
        name: name,
        age: int.parse(age),
        phoneNo: phoneNo,
        city: city,
        state: state,
        profileheading: profileheading,
        publishedDateTime: DateTime.now().microsecondsSinceEpoch

      );
      await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).set(personInstance.tojson());
      
      Get.snackbar("Account Created", "Congratulations, your account has been created.");
      Get.to(HomeScreen());
      

      } catch(errorMsg){

        Get.snackbar("Account Creation UNSUCCESSFUL", "error occured : $errorMsg");

      }



    }


}
