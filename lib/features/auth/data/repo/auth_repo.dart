import 'package:recipe/features/auth/data/data_source/auth_data_source.dart';
import 'package:recipe/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepo {
  AuthRepo(this._dataSource);

  final AuthDataSource _dataSource;

  // SignUp.
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final response = await _dataSource.signUp(
      email: email,
      password: password,
      fullName: fullName,
    );

    return response;
  }

  // SignIn.
  Future<UserModel> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _dataSource.signIn(email: email, password: password);

    return response;
  }

  // SignOut.
  Future<void> signOut() async {
    await _dataSource.signOut();
  }

  User? get currentUser => _dataSource.currentUser;
}
