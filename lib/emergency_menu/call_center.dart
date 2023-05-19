import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trizard/emergency_page/call_center_card.dart';
import 'package:trizard/theme.dart';

class CallCenter extends StatefulWidget {
  CallCenter({Key? key}) : super(key: key);

  @override
  State<CallCenter> createState() => _CallCenterState();
}

class _CallCenterState extends State<CallCenter> {
  SharedPreferences? preferences;

  String hp_call = '823 1233 1233';
  String hp_ambulance = '822 1212 1223';
  String hp_montir = '823 3333 3322';
  String hp_cop = '823 1233 1233';

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
                    image: AssetImage("assets/Call.png"), fit: BoxFit.cover),
              ),
            ),
            Text(
              "Call Center",
              style: blackStyle,
            )
          ],
        ),
      ),
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (BuildContext context) {
            return SingleChildScrollView(
              child: Container(
                alignment: Alignment.center,
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
                height: 600,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(20),
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.center,
                        child: Text(
                          'Call Center',
                          style: greenBlueStyle.copyWith(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                      CallCenterView(
                        iconss: 'assets/online-support.png',
                        no_hp: '+62${hp_call}',
                        label: 'Call Center',
                      ),
                      CallCenterView(
                        iconss: 'assets/ambulance.png',
                        no_hp: '+62${hp_ambulance}',
                        label: 'Ambulance',
                      ),
                      CallCenterView(
                        iconss: 'assets/mechanic.png',
                        no_hp: '+62${hp_montir}',
                        label: 'Mekanik',
                      ),
                      CallCenterView(
                        iconss: 'assets/cop.png',
                        no_hp: '+62${hp_cop}',
                        label: 'Polisi',
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
