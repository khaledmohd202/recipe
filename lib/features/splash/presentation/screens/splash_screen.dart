import 'package:flutter/material.dart';
import 'package:recipe/core/routing/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final _SplashAnimations _animations;

  @override
  void initState() {
    super.initState();
    _animations = _SplashAnimations(vsync: this);
    _startSequence();
  }

  Future<void> _startSequence() async {
    // Start circles immediately
    _animations.circlesController.forward();

    // Logo pops in
    await Future.delayed(const Duration(milliseconds: 200));
    _animations.logoController.forward();

    // Text slides up
    await Future.delayed(const Duration(milliseconds: 500));
    _animations.textController.forward();

    // Loading bar starts
    await Future.delayed(const Duration(milliseconds: 400));
    _animations.loadingController.forward();

    // Navigate when done
    await Future.delayed(const Duration(milliseconds: 2000));
    if (mounted) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.login);
    }
  }

  @override
  void dispose() {
    _animations.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFF8A65), Color(0xFFFF7043), Color(0xFFE64A19)],
          ),
        ),
        child: Stack(
          children: [
            // Background decorative circles
            _buildBackgroundCircles(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLogo(),
                  const SizedBox(height: 24),
                  _buildTitle(),
                  const SizedBox(height: 8),
                  _buildSubtitle(),
                ],
              ),
            ),
            _buildLoadingBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundCircles() {
    return AnimatedBuilder(
      animation: _animations.circlesOpacity,
      builder: (context, child) {
        return Stack(
          children: [
            Positioned(
              top: -60,
              right: -40,
              child: Opacity(
                opacity: _animations.circlesOpacity.value,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 40,
              right: 20,
              child: Opacity(
                opacity: _animations.circlesOpacity.value,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 80,
              left: -80,
              child: Opacity(
                opacity: _animations.circlesOpacity.value,
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLogo() {
    return AnimatedBuilder(
      animation: _animations.logoController,
      builder: (context, child) {
        return Opacity(
          opacity: _animations.logoOpacity.value,
          child: Transform.scale(
            scale: _animations.logoScale.value,
            child: Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.25),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Icon(
                Icons.restaurant,
                size: 48,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildTitle() {
    return AnimatedBuilder(
      animation: _animations.textController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _animations.textOpacity,
          child: SlideTransition(
            position: _animations.textSlide,
            child: const Text(
              'Recipe Finder',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 0.5,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSubtitle() {
    return AnimatedBuilder(
      animation: _animations.textController,
      builder: (context, child) {
        return FadeTransition(
          opacity: _animations.textOpacity,
          child: SlideTransition(
            position: _animations.textSlide,
            child: const Text(
              'COOK WITH PASSION',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
                letterSpacing: 3,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingBar() {
    return Positioned(
      bottom: 80,
      left: 0,
      right: 0,
      child: Column(
        children: [
          AnimatedBuilder(
            animation: _animations.loadingController,
            builder: (context, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80),
                child: Stack(
                  children: [
                    Container(
                      height: 2,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(1),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: _animations.loadingWidth.value,
                      child: Container(
                        height: 2,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 12),
          const Text(
            'LOADING KITCHEN',
            style: TextStyle(
              fontSize: 11,
              color: Colors.white60,
              letterSpacing: 2.5,
            ),
          ),
        ],
      ),
    );
  }
}

class _SplashAnimations {
  final AnimationController logoController;
  final AnimationController textController;
  final AnimationController loadingController;
  final AnimationController circlesController;

  late final Animation<double> logoScale;
  late final Animation<double> logoOpacity;
  late final Animation<Offset> textSlide;
  late final Animation<double> textOpacity;
  late final Animation<double> loadingWidth;
  late final Animation<double> circlesOpacity;

  _SplashAnimations({required TickerProvider vsync})
    : logoController = AnimationController(
        vsync: vsync,
        duration: const Duration(milliseconds: 800),
      ),
      textController = AnimationController(
        vsync: vsync,
        duration: const Duration(milliseconds: 600),
      ),
      loadingController = AnimationController(
        vsync: vsync,
        duration: const Duration(milliseconds: 1500),
      ),
      circlesController = AnimationController(
        vsync: vsync,
        duration: const Duration(milliseconds: 1200),
      ) {
    logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: logoController, curve: Curves.elasticOut),
    );

    logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: logoController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    textSlide = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: textController, curve: Curves.easeOut));

    textOpacity = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: textController, curve: Curves.easeIn));

    loadingWidth = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: loadingController, curve: Curves.easeInOut),
    );

    circlesOpacity = Tween<double>(
      begin: 0.0,
      end: 0.15,
    ).animate(CurvedAnimation(parent: circlesController, curve: Curves.easeIn));
  }

  void dispose() {
    logoController.dispose();
    textController.dispose();
    loadingController.dispose();
    circlesController.dispose();
  }
}
