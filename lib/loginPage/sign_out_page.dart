import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trizard/cubit/auth_cubit.dart';
import 'package:trizard/theme.dart';

class SignOut extends StatefulWidget {
  const SignOut({Key? key}) : super(key: key);

  @override
  State<SignOut> createState() => _SignOutState();
}

class _SignOutState extends State<SignOut> {
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(),
        BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthFailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(state.error),
                ),
              );
            } else if (state is AuthInitial) {
              Navigator.pushNamedAndRemoveUntil(
                  context, '/signIn-page', (route) => false);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return SizedBox(
              height: 40,
              width: 170,
              child: TextButton(
                onPressed: () {
                  preferences.clear();
                  context.read<AuthCubit>().signOut();
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: greenColor,
                ),
                child: Text(
                  'SignOut',
                  style: whiteStyle.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
