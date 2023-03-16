import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trizard/theme.dart';

class Sos_Call extends StatefulWidget {
  Sos_Call({Key? key}) : super(key: key);

  @override
  State<Sos_Call> createState() => _Sos_CallState();
}

class _Sos_CallState extends State<Sos_Call> {
  SharedPreferences? preferences;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/SOS.png"), fit: BoxFit.cover),
            ),
          ),
          Text(
            "SOS",
            style: blackStyle,
          )
        ],
      ),
    );
  }
}
