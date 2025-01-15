import 'package:basic_firebase_inheritage_widget/controller/person_page.dart';
import 'package:basic_firebase_inheritage_widget/view/auth_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAvd_ONRJ9RQhypzFst8sp-duEiBz8ACDU",
          appId: "1:1075455070542:android:949ba823f7218049210e1f",
          messagingSenderId: "1075455070542",
          projectId: "playernames-e4df3"));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Person(
        email: "ganesh",
        password: "ganesh",
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: AuthPage(),
        ));
  }
}
