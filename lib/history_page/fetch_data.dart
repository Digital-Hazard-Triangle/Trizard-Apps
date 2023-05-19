import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trizard/history_page/history_view.dart';
import 'package:trizard/history_page/update_record.dart';
import 'package:trizard/theme.dart';

class FetchData extends StatefulWidget {
  const FetchData({Key? key}) : super(key: key);

  @override
  State<FetchData> createState() => _FetchDataState();
}

class _FetchDataState extends State<FetchData> {
  Query dbRef = FirebaseDatabase.instance.ref().child('Data');

  late DatabaseReference dbReff;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    dbRef = FirebaseDatabase.instance.ref().child('Data');
  }

  Future<void> _usersname() async {
    final SharedPreferences prefs = await _prefs;
    final String? name = prefs.getString('nama');
    DatabaseReference reference =
        FirebaseDatabase.instance.ref().child('Data').child('${name}');
    reference.child('${name}').remove();
  }

  Widget listItem({required Map student}) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        height: 130,
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: 20,
              child: Text("EMERGENCY",
                  style: redkkStyle.copyWith(fontWeight: FontWeight.bold)),
            ),
            Text(
              'Status Kendaraan : ${student['condition']}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'latitude       : ${student['lat']}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'longitude    : ${student['long']}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // GestureDetector(
                //   onTap: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (_) =>
                //                 UpdateRecord(studentKey: student['key'])));
                //   },
                //   child: Row(
                //     children: [
                //       Icon(
                //         Icons.edit,
                //         color: Theme.of(context).primaryColor,
                //       ),
                //     ],
                //   ),
                // ),
                const SizedBox(
                  width: 6,
                ),
              ],
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MapSample(
                    latitude: double.parse('${student['lat']}'),
                    longitude: double.parse('${student['long']}'),
                    kondisi: '${student['condition']}',
                  )),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      height: double.infinity,
      child: FirebaseAnimatedList(
        query: dbRef,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map student = snapshot.value as Map;
          student['key'] = snapshot.key;

          return listItem(student: student);
        },
      ),
    ));
  }
}
