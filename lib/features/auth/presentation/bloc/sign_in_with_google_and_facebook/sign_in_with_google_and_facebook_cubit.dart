import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';

part 'sign_in_with_google_and_facebook_state.dart';

class SignInWithGoogleAndFacebookCubit
    extends Cubit<SignInWithGoogleAndFacebookState> {
  SignInWithGoogleAndFacebookCubit()
    : super(SignInWithGoogleAndFacebookInitial()) {
    _authSubscription = client.auth.onAuthStateChange.listen((data) {
      final session = data.session;
      if (data.event == AuthChangeEvent.signedIn &&
          session != null &&
          !isClosed) {
        Future.delayed(const Duration(milliseconds: 500), () {
          if (!isClosed) emit(FacebookSignInSuccess());
        });
      }
    });
  }

  SupabaseClient client = Supabase.instance.client;
  final googleSignIn = GoogleSignIn.instance;
  StreamSubscription? _authSubscription;

  Future<void> signInWithGoogle() async {
    emit(GoogleSignInLoading());
    try {
      // const webClientId =EnvHelper.webClientId;
      const webClientId =
          '534694929520-2hsem6av0mdq1l5kaeva6qsopgvbp8ju.apps.googleusercontent.com';
      final scopes = ['email', 'profile'];
      final googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize(serverClientId: webClientId);
      final googleUser = await googleSignIn.attemptLightweightAuthentication();
      if (googleUser == null) {
        throw AuthException('Failed to sign in with Google.');
      }
      final authorization =
          await googleUser.authorizationClient.authorizationForScopes(scopes) ??
          await googleUser.authorizationClient.authorizeScopes(scopes);
      final idToken = googleUser.authentication.idToken;
      if (idToken == null) {
        throw AuthException('No ID Token found.');
      }
      var response = await client.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken,
        accessToken: authorization.accessToken,
      );
      log("Response: $response");
      emit(GoogleSignInSuccess());
    } on Exception catch (e) {
      emit(GoogleSignInFailure(errorMessage: e.toString()));
      log("Error when to Sign in with google: $e");
    }
  }

  Future<void> signInWithFacebook() async {
    emit(FacebookSignInLoading());
    try {
      await client.auth.signInWithOAuth(
        OAuthProvider.facebook,
        redirectTo: "com.example.recipe://login-callback",
      );
      // log("Response:$response");
      // emit(FacebookSignInSuccess());
    } catch (e) {
      log("Facebook Sign In error: $e");
      emit(FacebookSignInFailure(errorMessage: e.toString()));
    }
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
