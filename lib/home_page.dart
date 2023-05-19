import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trizard/cards/account_cards.dart';
import 'package:trizard/cards/car_condition_message.dart';
import 'package:trizard/cards/device_status.dart';
import 'package:trizard/emergency_menu/call_center.dart';
import 'package:trizard/emergency_menu/sos_call.dart';
import 'package:trizard/history_page/history_view.dart';
import 'package:trizard/theme.dart';

class Dashboard extends StatefulWidget {
  Dashboard(
      {Key? key,
      required this.latt,
      required this.longg,
      required this.power_switch,
      required this.kondisi})
      : super(key: key);
  bool? power_switch;
  String? latt;
  String? longg;
  String? kondisi;

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Data');

  late DatabaseReference dbReff;
  SharedPreferences? preferences;
  Future inittt() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String? nama = preferences?.getString('nama');
    inittt();

    dbRef = FirebaseDatabase.instance.ref().child('Data');
  }

  Future init() async {
    preferences = await SharedPreferences.getInstance();
  }

  Future<void> _remove() async {
    String? name = '${preferences?.getString('nama')}';
    print('nama 2: ${name}');
    DatabaseReference reference =
        FirebaseDatabase.instance.ref().child('Data').child('${name}');
    reference.remove();
  }

  void refresh() {
    setState(() {
      print('refresh');
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
                  child: DeviceStatus(
                    lat: widget.latt,
                    long: widget.longg,
                    on_off: widget.power_switch,
                    kondisii: widget.kondisi,
                  ),
                ),
                CarStatus(),
              ],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CallCenter(),
              Sos_Call(),
            ],
          ),
        ),
        InkWell(
          child: Container(
            alignment: Alignment.center,
            margin: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20),
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Your Car Positions",
                    style: blackStyle.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  margin: EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
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
                  child: Row(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage("assets/triangle.png"),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          children: [
                            SizedBox(
                              child: Container(
                                width: 230,
                                margin: EdgeInsets.all(10),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.health_and_safety,
                                      color: Color.fromARGB(255, 7, 121, 77),
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(left: 20),
                                        width: 75,
                                        child: widget.power_switch == true
                                            ? Text(
                                                "On",
                                                style: blackStyle,
                                              )
                                            : Text(
                                                "off",
                                                style: blackStyle,
                                              )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Container(
                                width: 230,
                                margin: EdgeInsets.all(10),
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.gps_not_fixed,
                                      color: Color.fromARGB(255, 7, 121, 77),
                                    ),
                                    Container(
                                        padding: EdgeInsets.only(left: 20),
                                        width: 75,
                                        child: widget.power_switch == true
                                            ? Text(
                                                "${widget.latt}, ${widget.longg}",
                                                style: blackStyle,
                                              )
                                            : Text(
                                                "off",
                                                style: blackStyle,
                                              )),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              child: Container(
                                width: 230,
                                margin: EdgeInsets.all(10),
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.car_repair,
                                      color: Color.fromARGB(255, 7, 121, 77),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 20),
                                      width: 150,
                                      child: widget.power_switch == true
                                          ? SizedBox(
                                              width: 300,
                                              height: 50,
                                              child: Text(
                                                '${widget.kondisi}',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: greenBlueStyle.copyWith(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            )
                                          : SizedBox(
                                              width: 300,
                                              height: 50,
                                              child: Text(
                                                '-',
                                                overflow: TextOverflow.visible,
                                                maxLines: 2,
                                                style: greenBlueStyle.copyWith(
                                                    fontSize: 14),
                                              ),
                                            ),
                                    ),
                                    GestureDetector(
                                      onTap: (() async {
                                        _remove();
                                        setState(() {});
                                        refresh();
                                      }),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.delete,
                                            color: Colors.red[700],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MapSample(
                  latitude: double.parse('${widget.latt}'),
                  longitude: double.parse('${widget.longg}'),
                  kondisi: '${widget.kondisi}',
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
