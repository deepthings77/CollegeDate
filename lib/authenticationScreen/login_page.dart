import 'package:collegedate/authenticationScreen/registration_screen.dart';
import 'package:collegedate/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailtexteditingController = TextEditingController();
  TextEditingController passwordtexteditingController = TextEditingController();
  bool showProgressBar = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [

              Image.asset("images/logo11.png",
              
              ),
             const Text("Login To Connect",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              ),
              const SizedBox(
                height: 60,
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
               Container(
                 width: MediaQuery.of(context).size.width - 136,
                 height: 35,
                 decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12))
                 ),
                 child: InkWell(
                  onTap: (){

                  },
                  child: const Center(
                    child: Text("Login", style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
                    
                  ),
                 ),

               ),
               const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 const Text("Don't have an Account?",
                 style: TextStyle(fontSize: 16,
                 color: Colors.grey,
                 ),
                 ),
                 InkWell(
                  onTap: (){
                      Get.to(RegistrationScreen());
                  },
                  child:const Text("Click here",
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

              showProgressBar == true ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              ) : Container(),

            ]
          ),
        ),
      ),
    );
  }
}
