// ignore_for_file: prefer_const_constructors

import 'package:expense_tracker_v1/models/expense_data.dart';
import 'package:expense_tracker_v1/pages/home_page.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

void main() async {

  //Initialize Firebase
  /*WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();*/

  //Initialize Hive here

  await Hive.initFlutter();

  //Opening DB
  await Hive.openBox("expense_database");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      builder: (context, child) => MaterialApp(
        theme: ThemeData(fontFamily: 'Montserrat'),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      ),
    );
  }
}
