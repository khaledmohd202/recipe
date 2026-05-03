import 'package:flutter/material.dart';
import 'package:recipe/core/routing/routing_animation.dart';
import 'package:recipe/features/auth/presentation/screens/login_screen.dart';
import 'package:recipe/features/auth/presentation/screens/registration_screen.dart';
import 'package:recipe/features/home/presentation/home_screen.dart';
import 'package:recipe/features/splash/presentation/screens/splash_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';

  static Route<void> onGenerateRoute(RouteSettings settings) {
    // ignore: unused_local_variable
    final arguments = settings.arguments;

    switch (settings.name) {
      case splash:
        return AnimationRouting(page: SplashScreen());
      case login:
        return AnimationRouting(page: LoginScreen());
      case register:
        return AnimationRouting(page: RegistrationScreen());
      case home:
        return AnimationRouting(page: HomeScreen());

      default:
        // return kDebugMode
        // ?
        return AnimationRouting(
          page: Scaffold(
            body: Center(child: Text('Page not found ${settings.name}')),
          ),
        );
      // : AnimationRouting(page: const MainScreen());
    }
  }
}
