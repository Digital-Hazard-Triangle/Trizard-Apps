import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trizard/loginPage/sign_out_page.dart';
import 'package:trizard/theme.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  SharedPreferences? preferences;
  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    preferences = await SharedPreferences?.getInstance();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 76, 134, 122),
        title: Text(
          'Account',
          style: whiteStyle.copyWith(fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          constraints: BoxConstraints.expand(),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 200, 20, 20),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage('assets/mee.png'),
                      //backgroundImage: AssetImage('assets/mee.png'),
                      radius: 50,
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(15),
                      width: 200,
                      child: Text(
                        "${preferences?.getString('nama')}",
                        style: blackStyle.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 300,
                      child: Text(
                        "${preferences?.getString('email')}",
                        style: greykStyle.copyWith(fontSize: 14),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Column(
                        children: [],
                      ),
                    )
                  ],
                ),
              ),
              Container(),
              SignOut(),
            ],
          ),
        ),
      ),
    );
  }
}
