import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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
              try {
                await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text);
                Map<String, dynamic> data = {
                  "email": emailController.text,
                  "password": passwordController.text
                };
                DocumentReference docRef = FirebaseFirestore.instance
                    .collection("Users")
                    .doc(emailController.text);
                docRef.set(data);

                QuerySnapshot querySnapshot =
                    await FirebaseFirestore.instance.collection("Users").get();

                Map<String, dynamic> mapData = {};

                for (var val in querySnapshot.docs) {
                  mapData.addAll(val.data()as Map<String,dynamic>);
                  log(val.toString());

                }
                
              } on FirebaseAuthException catch (obj) {
                // log("Auth ${obj.message}");
                log("Email ${obj.message}");
              }
            },
            style: const ButtonStyle(
                backgroundColor:
                    WidgetStatePropertyAll(Color.fromARGB(255, 11, 215, 192))),
            child: const Padding(
              padding: EdgeInsets.all(12),
              child: Text("Submit"),
            ),
          )
        ],
      ),
    );
  }
}
