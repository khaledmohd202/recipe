import 'package:recipe/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthDataSource {
  AuthDataSource(this._client);

  final SupabaseClient _client;

  // SignUp.
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final response = await _client.auth.signUp(
      password: password,
      email: email,
      data: {'full_name': fullName},
    );

    return UserModel.fromSupabase(response);
  }

  // SignIn.
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _client.auth.signInWithPassword(
      password: password,
      email: email,
    );

    return UserModel.fromSupabase(response);
  }

  // SignOut.
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  // CurrentUser.
  User? get currentUser => _client.auth.currentUser;
}
