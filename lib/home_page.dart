import 'package:flutter/material.dart';
import 'package:trizard/cards/account_cards.dart';
import 'package:trizard/cards/car_condition_message.dart';
import 'package:trizard/cards/device_status.dart';
import 'package:trizard/emergency_menu/call_center.dart';
import 'package:trizard/emergency_menu/sos_call.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: 500,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/main_bg.png"), fit: BoxFit.cover),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
            margin: EdgeInsets.all(10),
            child: Column(
              children: [
                BarApp(),
                Container(
                  width: 1000,
                  margin: EdgeInsets.only(top: 50),
                  alignment: Alignment.center,
                  child: DeviceStatus(),
                ),
                CarStatus(),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CallCenter(),
            Sos_Call(),
          ],
        ),
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: 400,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/Mapp.png"), fit: BoxFit.cover),
            borderRadius: BorderRadius.circular(30),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(41, 0, 0, 0),
                blurStyle: BlurStyle.normal,
                spreadRadius: 0.0001,
                blurRadius: 5,
                offset: Offset(5, 5), // changes position of shadow
              ),
            ],
          ),
          child: Text("bagian Map"),
        )
      ],
    );
  }
}
