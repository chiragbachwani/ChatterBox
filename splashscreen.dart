import 'dart:async';
import 'package:chat_app/main.dart';
import 'package:chat_app/views/intro_screen/home_screen/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'const/firebase_const.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  var isUser = false;

  checkUser() async {
    auth.authStateChanges().listen((User? user) {
      if (user == null && mounted) {
        setState(() {
          isUser = false;
        });
      } else {
        setState(() {
          isUser = true;
        });
      }

      print("User value is $isUser");
    });
  }

  @override
  void initState() {
    gotoNextScreen();
    super.initState();
    checkUser();
  }

  gotoNextScreen() {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => isUser ? const HomeScreen() : const ChatApp()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/chatApp.gif",
              width: 250,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Chatter Box",
              style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.w400,
                  color: Colors.black),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
