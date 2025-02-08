
import 'package:flutter/material.dart';
import 'package:todolist/const/color.dart';
import 'package:todolist/data/auth_data.dart';

class SignUp_Screen extends StatefulWidget {
  final VoidCallback show;
  SignUp_Screen(this.show,{super.key});


  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3=FocusNode();


  final email = TextEditingController();
  final password = TextEditingController();
  final confirmpass=TextEditingController();
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
    super.initState();
    _focusNode3.addListener(() {
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
                  textfield( password,_focusNode2,"Password",Icons.password_rounded),
                  const SizedBox(
                    height: 21,
                  ),
                  textfield( confirmpass,_focusNode3,"ConfirmPassword",Icons.password_rounded),
                  const SizedBox(
                    height: 7,
                  ),
                  accountLogIn(),
                  const SizedBox(
                    height: 21,
                  ),
                  SignUpButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget accountLogIn() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Already have an account?  ",
            style: TextStyle(
                color: Colors.black,
                fontSize: 14.5,
                fontWeight: FontWeight.w200),
          ),
          GestureDetector(
            onTap: widget.show
            ,
            child: Text(
              "LogIn",
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

  Widget SignUpButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: (){
          AuthenticationRemote().register(email.text, password.text, confirmpass.text);
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
              'SignIn',
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

  Widget textfield(TextEditingController _controller,FocusNode _focusNode,String name,IconData icons) {
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
        controller: _controller,
        focusNode: _focusNode,
        style: TextStyle(fontSize: 18, color: Colors.black),
        decoration: InputDecoration(
          prefixIcon: Icon(icons),
          contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          hintText: name,
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
