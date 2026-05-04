import 'package:supabase_flutter/supabase_flutter.dart';

class UserModel {
  const UserModel({
    required this.id,
    required this.email,
    required this.fullName,
    this.token,
  });

  final String id;
  final String email;
  final String fullName;
  final String? token;

  factory UserModel.fromSupabase(AuthResponse response) {
    return UserModel(
      id: response.user!.id,
      email: response.user!.email ?? '',
      fullName: response.user!.userMetadata?['full_name'] ?? '',
      token: response.session?.accessToken,
    );
  }
}
