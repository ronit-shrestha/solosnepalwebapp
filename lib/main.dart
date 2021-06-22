import 'package:completesoloswebsite/screens/home/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
            appBarTheme: AppBarTheme(
                centerTitle: true,
                backgroundColor: Colors.black,
                shadowColor: Colors.white)),
        home: HomePage());
  }
}
