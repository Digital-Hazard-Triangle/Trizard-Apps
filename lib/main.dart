import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trizard/account_view.dart';
import 'package:trizard/cubit/auth_cubit.dart';
import 'package:trizard/home_page.dart';
import 'package:trizard/loginPage/sign_in_page.dart';
import 'package:trizard/loginPage/sign_up_page.dart';
import 'package:trizard/settings/settings_view.dart';
import 'package:trizard/spalsh_page.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Future<FirebaseApp> firebaseApp = Firebase.initializeApp();
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
  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Dashboard(),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 207, 0, 86),
        onPressed: () async {
          setState(() {});
          refresh();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
