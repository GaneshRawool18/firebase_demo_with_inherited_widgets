import 'package:flutter/material.dart';
import 'package:inherited_widget_demo_with_firebase/controller/person_controller.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  Widget build(BuildContext context) {
    final personData = Person.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
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
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Email : ${personData.email ?? "Email not found"}"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Password : ${personData.password ?? "Password not found"}"),
                    ),
                  ],
                )),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
