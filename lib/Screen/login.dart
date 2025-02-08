import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist/const/color.dart';
import 'package:todolist/data/auth_data.dart';

class LogIn_Screen extends StatefulWidget {
  final VoidCallback show;

  LogIn_Screen(this.show, {super.key});

  State<LogIn_Screen> createState() => _LogIn_ScreenState();
}

class _LogIn_ScreenState extends State<LogIn_Screen> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();

  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    super.initState();
    _focusNode2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background gradient filling the entire screen
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft, // Adjust alignment if needed
                end: Alignment.bottomRight,
                colors: [Colors.black12, Colors.white],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 21),
                  Center(child: image()),
                  const SizedBox(height: 55),
                  textfield_email(),
                  const SizedBox(
                    height: 21,
                  ),
                  textfield_password(),
                  const SizedBox(
                    height: 7,
                  ),
                  accountSignUp(),
                  const SizedBox(
                    height: 21,
                  ),
                  LoginButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget accountSignUp() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Dont't have an account?  ",
            style: TextStyle(
                color: Colors.black,
                fontSize: 14.5,
                fontWeight: FontWeight.w200),
          ),
          GestureDetector(
            onTap: widget.show,
            onDoubleTap: (){print('helooo');},
            child: Text(
              "SignUp",
              style: TextStyle(
                  color: custom_green,
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget LoginButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () async{
          print('he,lloo login');
          await AuthenticationRemote().login(email.text, password.text);
        },
        child: Container(
          width: 200,
          height: 40,
          decoration: BoxDecoration(
            color: custom_green,
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(15), bottom: Radius.elliptical(12, 10)),
          ),
          child: Center(
            child: Text(
              'LogIn',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget textfield_email() {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white54, Colors.white]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: email,
        focusNode: _focusNode1,
        style: TextStyle(fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail_outline_rounded),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          hintText: 'Email',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white60, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: custom_green, width: 2)),
        ),
      ),
    );
  }

  Widget textfield_password() {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white54, Colors.white]),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller: password,
        focusNode: _focusNode2,
        style: TextStyle(fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.password_rounded),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          hintText: 'Password',
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white60, width: 2)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: custom_green, width: 2)),
        ),
      ),
    );
  }

  Padding image() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/1.webp'), fit: BoxFit.cover)),
      ),
    );
  }
}
