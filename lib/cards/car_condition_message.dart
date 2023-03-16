import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trizard/theme.dart';

class CarStatus extends StatefulWidget {
  CarStatus({Key? key}) : super(key: key);

  @override
  State<CarStatus> createState() => _CarStatusState();
}

class _CarStatusState extends State<CarStatus> {
  SharedPreferences? preferences;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    preferences = await SharedPreferences?.getInstance();
  }

  TextEditingController? _status_mobil;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 20),
      child: TextField(
        controller: _status_mobil,
        keyboardType: TextInputType.phone,
        cursorColor: Color.fromARGB(255, 255, 0, 179),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 255, 0, 98)),
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 255, 0, 76)),
            borderRadius: BorderRadius.circular(15),
          ),
          labelText: '✏️ Status Mobil (Bocor ban, mesin rusak, dll)',
          labelStyle:
              whiteStyle.copyWith(color: Color.fromARGB(255, 77, 77, 77)),
        ),
        onSubmitted: (String umur) {
          try {} catch (e) {}
        },
      ),
    );
  }
}
