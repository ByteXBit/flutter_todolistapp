import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist/Auth/auth_page.dart';
import 'package:todolist/Auth/main_page.dart';
import 'package:todolist/Screen/SignUp.dart';
import 'package:todolist/Screen/login.dart';
import 'package:todolist/widget/task_widgets.dart';

import 'Screen/home.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Screen/listscreen.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

        useMaterial3: true,
      ),
      home: mainpage(),
    );
  }
}


