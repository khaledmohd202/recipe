part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {
  AuthSuccess(this.user);
  final UserModel user;
}

final class AuthFailure extends AuthState {
  AuthFailure(this.message);
  final String message;
}

final class AuthSignedOut extends AuthState {}
