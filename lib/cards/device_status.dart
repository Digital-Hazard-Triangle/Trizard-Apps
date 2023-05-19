import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trizard/history_page/history_view.dart';
import 'package:trizard/theme.dart';

class DeviceStatus extends StatefulWidget {
  DeviceStatus(
      {Key? key,
      required this.lat,
      required this.long,
      required this.on_off,
      required this.kondisii})
      : super(key: key);
  bool? on_off;
  String? lat;
  String? long;
  String? kondisii;
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
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 10, 60),
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
                        margin: EdgeInsets.all(10),
                        alignment: Alignment.centerLeft,
                        child: widget.on_off == true
                            ? Icon(
                                Icons.notifications_active,
                                color: Color.fromARGB(255, 13, 255, 162),
                              )
                            : Icon(
                                Icons.notifications_active,
                                color: Color.fromARGB(255, 128, 129, 129),
                              ),
                      ),
                      Container(
                          width: 100,
                          alignment: Alignment.centerLeft,
                          child: widget.on_off == true
                              ? Text(
                                  "On",
                                  style: whiteStyle,
                                )
                              : Text(
                                  "off",
                                  style: whiteStyle,
                                )),
                    ],
                  ),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          alignment: Alignment.topLeft,
                          child: widget.on_off == true
                              ? Icon(
                                  Icons.gps_fixed_rounded,
                                  color: Color.fromARGB(255, 13, 255, 162),
                                )
                              : Icon(
                                  Icons.gps_fixed_rounded,
                                  color: Color.fromARGB(255, 108, 109, 109),
                                ),
                        ),
                        Container(
                          width: 100,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "${widget.lat}, ${widget.long}",
                            style: whiteStyle,
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapSample(
                            latitude: double.parse('${widget.lat}'),
                            longitude: double.parse('${widget.long}'),
                            kondisi: '${widget.kondisii}',
                          ),
                        ),
                      );
                    },
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
