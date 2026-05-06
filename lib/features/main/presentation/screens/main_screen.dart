import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recipe/features/favorites/presentation/screens/favorites_screen.dart';
import 'package:recipe/features/home/presentation/screens/home_screen.dart';
import 'package:recipe/features/main/presentation/widgets/bottom_nav_item.dart';
import 'package:recipe/features/profile/presentation/screens/profile_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> _screens = [
    HomeScreen(),
    FavoritesScreen(),
    ProfileScreen(),
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: SafeArea(
        child: Container(
          height: 55.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.2),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BottomNavItem(
                activeIcon: Icons.home,
                currentIndex: _currentIndex,
                icon: Icons.home_outlined,
                index: 0,
                label: 'HOME',
                onTap: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
              ),
              BottomNavItem(
                activeIcon: Icons.favorite,
                currentIndex: _currentIndex,
                icon: Icons.favorite_outline,
                index: 1,
                label: 'FAVORITES',
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
              ),
              BottomNavItem(
                activeIcon: Icons.person_2,
                currentIndex: _currentIndex,
                icon: Icons.person_2_outlined,
                index: 2,
                label: 'PROFILE',
                onTap: () {
                  setState(() {
                    _currentIndex = 2;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
