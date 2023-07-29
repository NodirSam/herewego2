import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:herewego/pages/main_page.dart';
import 'package:herewego/pages/signin_page.dart';

import '../services/auth_service.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);
  static const String id = "signup_page";

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  var isLoading = false;
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var cpasswordController = TextEditingController();

  void _callSignInPage() {
    Navigator.pushReplacementNamed(context, SignInPage.id);
  }

  void _doSignIn(){
    String fullName = fullNameController.text.toString().trim();
    String email = emailController.text.toString().trim();
    String password = passwordController.text.toString().trim();
    String cpassword = cpasswordController.text.toString().trim();

    if (fullName.isEmpty || email.isEmpty || password.isEmpty) return;
    if (cpassword != password) {
      print("Password and confirm password does not match");
      return;
    }

    setState(() {
      isLoading = true;
    });

    AuthService.signUpUser(fullName, email, password).then((value) => {
      responseSignUp(value!),
    });

  }

  void responseSignUp(User firebaseUser){
    setState(() {
      isLoading = false;
    });
    Navigator.pushReplacementNamed(context, MainPage.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

                //#fullName
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    controller: fullNameController,
                    decoration: const InputDecoration(
                      hintText: "FullName",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
                    ),
                  ),
                ),

                const SizedBox(height: 10,),


                //#email
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
                    ),
                  ),
                ),

                const SizedBox(height: 10,),


                //#password
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
                    ),
                  ),
                ),

                const SizedBox(height: 10,),


                //#cpassword
                Container(
                  height: 50,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    controller: cpasswordController,
                    decoration: const InputDecoration(
                      hintText: "Confirm Password",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 17),
                    ),
                  ),
                ),

                const SizedBox(height: 10,),

                //#sign up
                GestureDetector(
                  onTap: _doSignIn,
                  child: Container(
                    height: 50,
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const Center(
                      child: Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Already have an account?",
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: _callSignInPage,
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),

              ],
            ),

            isLoading
                ? const Center(
              child: CircularProgressIndicator(),
            )
                : const SizedBox.shrink()

          ],
        ),
      ),
    );
  }
}
