import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trizard/cubit/auth_cubit.dart';
import 'package:trizard/loginPage/sign_in_page.dart';
import 'package:trizard/widgets/costume_text_form_field.dart';

import '../theme.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController(text: '');

  final TextEditingController emailController = TextEditingController(text: '');

  final TextEditingController passwordController =
      TextEditingController(text: '');

  String? nama = '';

  String? email = '';

  @override
  void initState() {
    super.initState();
    init();
  }

  late SharedPreferences preferences;

  Future init() async {
    preferences = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 95, left: 45),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/triangle.png"),
                    ),
                  ),
                ),
                Text(
                  'Trizard',
                  style: GoogleFonts.aBeeZee(
                    fontSize: 40,
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  bottom: 40,
                  right: 35,
                  left: 35,
                ),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5,
                        sigmaY: 5,
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 35,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white24.withOpacity(0.1),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                CostomTextFromField(
                                  hintext: 'User Name',
                                  icon: Icons.person,
                                  controller: nameController,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CostomTextFromField(
                                  hintext: 'Email Address',
                                  icon: Icons.email_rounded,
                                  controller: emailController,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CostomTextFromField(
                                  hintext: 'Password',
                                  icon: Icons.lock,
                                  obscureText: true,
                                  controller: passwordController,
                                ),
                                BlocConsumer<AuthCubit, AuthState>(
                                  listener: (context, state) {
                                    if (state is AuthSuccess) {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context, '/main', (route) => false);
                                    } else if (state is AuthFailed) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          backgroundColor: Colors.red,
                                          content: Text(state.error),
                                        ),
                                      );
                                    }
                                  },
                                  builder: (context, state) {
                                    if (state is AuthLoading) {
                                      return const Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }

                                    return Container(
                                      margin: const EdgeInsets.only(
                                          top: 30, bottom: 20),
                                      height: 53,
                                      width: 177,
                                      child: TextButton(
                                        onPressed: () {
                                          context.read<AuthCubit>().signUp(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                                name: nameController.text,
                                              );
                                          try {
                                            preferences.clear();
                                            preferences.setString(
                                                'nama', nameController.text);
                                            preferences.setString(
                                                'email', emailController.text);
                                          } catch (e) {}
                                          ;
                                        },
                                        style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          backgroundColor: kprimeColor,
                                        ),
                                        child: Text(
                                          'Register',
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Have an account?',
                                      style: whiteStyle.copyWith(),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignInPage()));
                                      },
                                      child: Text(
                                        'Sign In',
                                        style: whiteStyle.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
