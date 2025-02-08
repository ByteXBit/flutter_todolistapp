import 'package:flutter/material.dart';
import 'package:todolist/Screen/SignUp.dart';
import 'package:todolist/Screen/login.dart';


class Auth_Page extends StatefulWidget{
  const Auth_Page({super.key});


  @override
  State<Auth_Page> createState() {
    // TODO: implement createState
    return _Auth_PageState();
  }

}

class _Auth_PageState extends State<Auth_Page>{

  bool a=true;

  void to(){
    setState(() {
      a=!a;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(a){
      return LogIn_Screen(to);
    }else{
      return SignUp_Screen(to);
    }
  }

}
