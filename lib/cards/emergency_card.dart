import 'package:flutter/material.dart';
import 'package:trizard/history_page/map_view.dart';
import 'package:trizard/theme.dart';

class EmergencyCard extends StatefulWidget {
  EmergencyCard({super.key});

  @override
  State<EmergencyCard> createState() => _EmergencyCardState();
}

class _EmergencyCardState extends State<EmergencyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Container(
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
          child: Column(
            children: [
              Container(
                height: 20,
                child: Text("EMERGENCY",
                    style: redkkStyle.copyWith(fontWeight: FontWeight.bold)),
              ),
              Container(
                height: 20,
                width: MediaQuery.of(context).size.width,
                child: Text("Car Status : ${"asdasdkhwaldlkawlkdjawli"}",
                    style: blackStyle),
              ),
              Container(
                height: 20,
                width: MediaQuery.of(context).size.width,
                child: Text("Location : ${"(5.4, 21.123123))"}",
                    style: blackStyle),
              )
            ],
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MapView()),
          );
        },
      ),
    );
  }
}
