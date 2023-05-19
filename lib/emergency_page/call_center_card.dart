import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:trizard/theme.dart';

class CallCenterView extends StatelessWidget {
  CallCenterView(
      {super.key,
      required this.no_hp,
      required this.iconss,
      required this.label});
  String no_hp;
  String iconss;
  String label;

  @override
  Widget build(BuildContext context) {
    return Container(
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("${iconss}"), fit: BoxFit.cover),
                ),
              ),
              Text(
                '${label}',
                style: greenBlueStyle,
              )
            ],
          ),
          Container(
            width: 200,
            child: Text(
              '${no_hp}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }
}
