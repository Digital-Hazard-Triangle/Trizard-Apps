import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trizard/cubit/auth_cubit.dart';
import 'package:trizard/theme.dart';
import 'package:trizard/widgets/costume_text_form_field.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController(text: '');

  final TextEditingController passwordController =
      TextEditingController(text: '');

  final TextEditingController namaController = TextEditingController(text: '');

  String? email = '';
  String? nama = '';

  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    init();
  }

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
                      image: AssetImage('assets/logo_app.png'),
                    ),
                  ),
                ),
                Text(
                  'Milesight',
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
                                  hintext: 'Nama',
                                  icon: Icons.person,
                                  controller: namaController,
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
                                          try {
                                            preferences.remove('email');
                                            preferences.setString(
                                                'email', emailController.text);
                                            preferences.remove('nama');
                                            preferences.setString(
                                                'nama', namaController.text);
                                          } catch (e) {}
                                          ;
                                          context.read<AuthCubit>().signIn(
                                                email: emailController.text,
                                                password:
                                                    passwordController.text,
                                              );
                                        },
                                        style: TextButton.styleFrom(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          backgroundColor: kprimeColor,
                                        ),
                                        child: Text(
                                          'Login',
                                          style: GoogleFonts.poppins(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Don’t have an account yet?',
                                      style: whiteStyle.copyWith(),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, '/signUp-page');
                                      },
                                      child: Text(
                                        'Sign Up',
                                        style: whiteStyle.copyWith(
                                          fontWeight: FontWeight.bold,
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
