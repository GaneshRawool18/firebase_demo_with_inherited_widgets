import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inherited_widget_demo_with_firebase/controller/person_controller.dart';
import 'package:inherited_widget_demo_with_firebase/view/first_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void clearController() {
    emailController.clear();
    passwordController.clear();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(30),
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                  offset: Offset(0, 4),
                  color: Colors.black,
                  blurRadius: 10,
                  blurStyle: BlurStyle.outer)
            ], borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      hintText: "Enter email", border: InputBorder.none)),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(30),
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                  offset: Offset(0, 4),
                  color: Colors.black,
                  blurRadius: 10,
                  blurStyle: BlurStyle.outer)
            ], borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      hintText: "Enter password", border: InputBorder.none)),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            onPressed: () async {
              if (emailController.text.trim().isNotEmpty &&
                  passwordController.text.trim().isNotEmpty) {
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: emailController.text.trim(),
                      password: passwordController.text.trim());
                  Map<String, dynamic> data = {
                    "email": emailController.text,
                    "password": passwordController.text
                  };
                  DocumentReference docRef = FirebaseFirestore.instance
                      .collection("Users")
                      .doc(emailController.text);
                  docRef.set(data);

                  Person.of(context)
                      .getMap(emailController.text.trim(), passwordController.text.trim());
                  clearController();

                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return const FirstScreen();
                  }));
                } on FirebaseAuthException catch (obj) {
                  // log("Auth ${obj.message}");
                  log("Email :  ${obj.message}");
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("${obj.message}"),
                    duration: const Duration(seconds: 5),
                    backgroundColor: const Color.fromARGB(255, 251, 56, 38),
                  ));
                } on FirebaseException catch (e) {
                  log("Error : ${e.message}");
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("${e.message}"),
                    duration: const Duration(seconds: 5),
                    backgroundColor: const Color.fromARGB(255, 251, 56, 38),
                  ));
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("All fields are required"),
                  duration: Duration(seconds: 5),
                  backgroundColor: Color.fromARGB(255, 251, 56, 38),
                ));
              }
            },
            style: const ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(Color.fromARGB(255, 11, 215, 192))),
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Text("Sign Up"),
            ),
          )
        ],
      ),
    );
  }
}
