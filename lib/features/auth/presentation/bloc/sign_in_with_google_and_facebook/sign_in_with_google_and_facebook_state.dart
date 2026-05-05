part of 'sign_in_with_google_and_facebook_cubit.dart';

@immutable
sealed class SignInWithGoogleAndFacebookState {}

final class SignInWithGoogleAndFacebookInitial
    extends SignInWithGoogleAndFacebookState {}

final class GoogleSignInLoading extends SignInWithGoogleAndFacebookState {}

final class GoogleSignInSuccess extends SignInWithGoogleAndFacebookState {}

final class GoogleSignInFailure extends SignInWithGoogleAndFacebookState {
  final String errorMessage;

  GoogleSignInFailure({required this.errorMessage});
}

final class FacebookSignInLoading extends SignInWithGoogleAndFacebookState {}

final class FacebookSignInSuccess extends SignInWithGoogleAndFacebookState {}

final class FacebookSignInFailure extends SignInWithGoogleAndFacebookState {
  final String errorMessage;

  FacebookSignInFailure({required this.errorMessage});
}
