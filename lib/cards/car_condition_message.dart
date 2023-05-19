import 'package:firebase_database/firebase_database.dart';
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
  late DatabaseReference dbRef;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    init();
    dbRef = FirebaseDatabase.instance.ref().child('Data');
  }

  Future init() async {
    preferences = await SharedPreferences.getInstance();
  }

  TextEditingController? _status_mobil;

  Future<String?> _usersname(String kondisi) async {
    final SharedPreferences prefs = await _prefs;
    final String? name = prefs.getString('nama');

    Map<String, String> students = {
      'condition': kondisi,
      'lat': '22',
      'long': '33',
    };

    dbRef.child('${name}').set(students);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 20),
      child: Column(
        children: [
          TextField(
            controller: _status_mobil,
            keyboardType: TextInputType.text,
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
              labelStyle: whiteStyle.copyWith(
                  color: Color.fromARGB(255, 104, 104, 104)),
            ),
            onSubmitted: (String kondisi) {
              try {
                _usersname(kondisi);
              } catch (e) {}
            },
          ),
        ],
      ),
    );
  }
}
