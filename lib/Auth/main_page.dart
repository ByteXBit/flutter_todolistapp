import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todolist/Screen/home.dart';
import 'auth_page.dart';
import 'package:todolist/Screen/listscreen.dart';

class mainpage extends StatelessWidget {
  const mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
              if(snapshot.hasData){
                return Listscreen();
              }else{
                return Auth_Page();
              }
          }),
    );
  }
}
