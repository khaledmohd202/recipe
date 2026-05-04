import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe/core/di/injection_container.dart';
import 'package:recipe/features/auth/presentation/bloc/auth_cubit.dart';
import 'package:recipe/features/auth/presentation/refactors/login_body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthCubit>(),
      child: LoginBody(),
    );
  }
}
