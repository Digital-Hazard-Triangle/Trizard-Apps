import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trizard/theme.dart';

class BarApp extends StatefulWidget {
  BarApp({Key? key}) : super(key: key);

  @override
  State<BarApp> createState() => _BarAppState();
}

class _BarAppState extends State<BarApp> {
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
      margin: EdgeInsets.only(top: 20),
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            child: SizedBox(
              width: 260,
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/mee.png'),
                    radius: 30,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 10),
                        width: 150,
                        child: Text("Selamat datang!",
                            style: whiteStyle.copyWith(fontSize: 12)),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: const EdgeInsets.only(left: 10),
                        width: 150,
                        child: Text(
                          "${preferences?.getString('nama')}",
                          style: whiteStyle.copyWith(fontSize: 22),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            onTap: () {
              Navigator.pushNamed(context, '/account');
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: const Icon(
              Icons.settings,
              color: Color.fromARGB(255, 255, 255, 255),
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
