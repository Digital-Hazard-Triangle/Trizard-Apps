// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trizard/model/user_model.dart';
import 'package:trizard/services/auth_service.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void signIn({
    required String email,
    required String password,
  }) async {
    try {
      emit(AuthLoading());

      UserModel user = await AuthService().signIn(
        email: email,
        password: password,
      );

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      emit(AuthLoading());
      UserModel user = await AuthService().signUp(
        name: name,
        email: email,
        password: password,
      );

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  void signOut() async {
    try {
      emit(AuthLoading());
      await AuthService().signOut();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
