import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        Navigator.pushNamedAndRemoveUntil(
            context, '/signUp-page', (route) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: const BoxConstraints.tightForFinite(),
        color: Colors.white,
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 600,
              height: 300,
              margin: const EdgeInsets.only(bottom: 15),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/triangle.png"),
                ),
              ),
            ),
            Text(
              'Milesight',
              style: GoogleFonts.aBeeZee(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 10,
                  color: Colors.redAccent),
            ),
          ],
        )),
      ),
    );
  }
}
