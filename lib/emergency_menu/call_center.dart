import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trizard/theme.dart';

class CallCenter extends StatefulWidget {
  CallCenter({Key? key}) : super(key: key);

  @override
  State<CallCenter> createState() => _CallCenterState();
}

class _CallCenterState extends State<CallCenter> {
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
                  image: AssetImage("assets/Call.png"), fit: BoxFit.cover),
            ),
          ),
          Text(
            "Call Center",
            style: blackStyle,
          )
        ],
      ),
    );
  }
}
