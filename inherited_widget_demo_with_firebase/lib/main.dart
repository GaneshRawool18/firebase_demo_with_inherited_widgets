import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:inherited_widget_demo_with_firebase/controller/person_controller.dart';
import 'package:inherited_widget_demo_with_firebase/view/auth_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBuQ-dYKSW1w3283PfulWelTNXFmMcULYc",
          appId: "1:378526489682:android:a3bf6606435ae3b9a1138b",
          messagingSenderId: "378526489682",
          projectId: "todoapp-6ac41"));
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
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
