import 'package:flutter/material.dart';
import 'package:trizard/theme.dart';

class ThresholdPage extends StatefulWidget {
  ThresholdPage({Key? key}) : super(key: key);

  @override
  State<ThresholdPage> createState() => _ThresholdPageState();
}

class _ThresholdPageState extends State<ThresholdPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 76, 134, 122),
        title: Text(
          'Settings',
          style: whiteStyle.copyWith(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            InkWell(
              child: Container(
                margin: EdgeInsets.all(20),
                height: 300,
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}
