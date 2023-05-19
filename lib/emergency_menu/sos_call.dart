import 'package:flutter/cupertino.dart';
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
    return InkWell(
        child: Container(
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
        ),
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return CupertinoAlertDialog(
                  title: Text(
                    'SOS Services',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.red),
                  ),
                  content:
                      Text('Apakah anda yakin ingin\nmenggunakan layanan SOS?'),
                  actions: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white),
                      child: Text(
                        'No',
                        style: blackStyle,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 252, 0, 0)),
                      child: Text('Yes'),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              });
        });
  }
}
