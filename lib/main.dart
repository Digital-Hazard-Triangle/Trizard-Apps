import 'dart:ffi';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trizard/account_view.dart';
import 'package:trizard/cubit/auth_cubit.dart';
import 'package:trizard/history_page/fetch_data.dart';
import 'package:trizard/home_page.dart';
import 'package:trizard/loginPage/sign_in_page.dart';
import 'package:trizard/loginPage/sign_up_page.dart';
import 'package:trizard/notif.dart';
import 'package:trizard/settings/settings_view.dart';
import 'package:trizard/spalsh_page.dart';
import 'package:trizard/theme.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Future<FirebaseApp> firebaseApp = Firebase?.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const SplashPage(),
          '/signIn-page': (context) => SignInPage(),
          '/signUp-page': (context) => SignUpPage(),
          '/main': (context) => MyHomePage(),
          '/settings': (context) => ThresholdPage(),
          '/account': (context) => AccountPage(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  SharedPreferences? preferences;
  bool trigger = false;
  Future inittt() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    Notif.initialize(flutterLocalNotificationsPlugin);
    String? nama = preferences?.getString('nama');

    inittt();
    getSensorsValue;
  }

  Future<Map<String?, dynamic>?> getSensorsValue() async {
    try {
      String? nama = preferences?.getString('nama');
      Uri url = Uri.parse(
          "https://trizard-9fbfe-default-rtdb.asia-southeast1.firebasedatabase.app/Data/${nama}.json");

      var response = await http.get(url);
      var json_response = json.decode(response.body);
      print('data : ${json_response}');
      print('nama : ${nama}');
      trigger = true;
      return json_response as Map<String, dynamic>;
    } catch (e) {
      return null;
    }
  }

  void refresh() {
    setState(() {
      print('refresh');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              child: Container(
                child: FutureBuilder<Map<String?, dynamic>?>(
                  future: getSensorsValue(),
                  builder: (context, snapshot) {
                    if (snapshot.data?['condition'] == null &&
                        snapshot.data?['lat'] == null &&
                        snapshot.data?['long'] == null) {
                      return Dashboard(
                        power_switch: false,
                        latt: '0',
                        longg: '0',
                        kondisi: '-',
                      );
                    } else {
                      return Dashboard(
                        power_switch: true,
                        latt: '${snapshot.data?['lat']}',
                        longg: '${snapshot.data?['long']}',
                        kondisi: '${snapshot.data?['condition']}',
                      );
                    }
                  },
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 5),
              child: SizedBox(
                height: 320,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 20),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Emergency Car List",
                        style: blackStyle.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    SizedBox(
                      height: 300.0,
                      child: FetchData(),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 10,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 105, 187, 149),
        onPressed: () async {
          setState(() {});
          refresh();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
