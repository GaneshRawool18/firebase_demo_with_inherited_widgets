import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:inherited_widget_demo_with_firebase/view/second_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();
    firebaseGetData();
  }

  List<Map<String, dynamic>> mapData = [];

  void firebaseGetData() async {
    QuerySnapshot docData =
        await FirebaseFirestore.instance.collection("Users").get();
    List<QueryDocumentSnapshot> listDoc = docData.docs;
    for (QueryDocumentSnapshot val in listDoc) {
      mapData.add(val.data() as Map<String, dynamic>);
    }
    log(mapData.toString());
    setState(() {});
    // Person.of(context).personData.(mapData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          itemCount: mapData.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
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
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text("Email : ${mapData[index]["email"]}"),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child:
                              Text("Password : ${mapData[index]["password"]}"),
                        ),
                      ],
                    )),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return const SecondScreen();
          }));
        },
        child: const Text(
          "Next",
        ),
      ),
    );
  }
}
