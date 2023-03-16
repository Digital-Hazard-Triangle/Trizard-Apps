import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trizard/theme.dart';

class DeviceStatus extends StatefulWidget {
  DeviceStatus({Key? key}) : super(key: key);

  @override
  State<DeviceStatus> createState() => _DeviceStatusState();
}

class _DeviceStatusState extends State<DeviceStatus> {
  SharedPreferences? preferences;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    preferences = await SharedPreferences?.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: 500,
            child:
                Text("Device Status", style: whiteStyle.copyWith(fontSize: 18)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 20),
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/triangle.png"),
                      fit: BoxFit.cover),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Container(
                        height: 70,
                        margin: EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.notifications_active,
                          color: Color.fromARGB(255, 13, 255, 162),
                        ),
                      ),
                      Container(
                        width: 100,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "On",
                          style: whiteStyle,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 70,
                        margin: EdgeInsets.all(10),
                        alignment: Alignment.topLeft,
                        child: Icon(
                          Icons.gps_fixed_rounded,
                          color: Color.fromARGB(255, 13, 255, 162),
                        ),
                      ),
                      Container(
                        width: 100,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Jl. awoijgijawjoojawfpj, faowijfiwajfa, afwoijiwj",
                          style: whiteStyle,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
