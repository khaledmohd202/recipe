import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/features/auth/data/models/user_model.dart';
import 'package:recipe/features/auth/data/repo/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repo) : super(AuthInitial());

  final AuthRepo _repo;

  // SignUp.
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    emit(AuthLoading());

    try {
      final user = await _repo.signUp(
        email: email,
        password: password,
        fullName: fullName,
      );

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // SignIn
  Future<void> signIn({required String email, required String password}) async {
    emit(AuthLoading());

    try {
      final user = await _repo.signIn(email: email, password: password);

      emit(AuthSuccess(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  // SignOut.
  Future<void> signOut() async {
    emit(AuthLoading());
    try {
      await _repo.signOut();
      emit(AuthSignedOut());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
