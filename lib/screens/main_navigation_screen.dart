import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_colors.dart';
import 'home_screen.dart';
import 'rewards_screen.dart';
import 'logs_screen.dart';
import 'hunter_profile_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    RewardsScreen(),
    LogsScreen(),
    HunterProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: AppColors.primaryCyan.withAlpha(30),
              width: 1,
            ),
          ),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: AppColors.background,
          selectedItemColor: AppColors.primaryCyan,
          unselectedItemColor: AppColors.textSecondary,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedLabelStyle: GoogleFonts.shareTechMono(
            fontSize: 10,
            letterSpacing: 1.5,
            fontWeight: FontWeight.bold,
          ),
          unselectedLabelStyle: GoogleFonts.shareTechMono(
            fontSize: 10,
            letterSpacing: 1.5,
          ),
          items: [
            _buildNavItem(Icons.home_outlined, Icons.home, 'HOME', 0),
            _buildNavItem(Icons.menu_book_outlined, Icons.menu_book, 'REWARDS', 1),
            _buildNavItem(Icons.history_outlined, Icons.history, 'LOG', 2),
            _buildNavItem(Icons.person_outline, Icons.person, 'HUNTER', 3),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(
      IconData icon, IconData activeIcon, String label, int index) {
    final isSelected = _currentIndex == index;
    return BottomNavigationBarItem(
      icon: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: isSelected
            ? BoxDecoration(
                color: AppColors.primaryCyan.withAlpha(25),
                borderRadius: BorderRadius.circular(8),
              )
            : null,
        child: Icon(isSelected ? activeIcon : icon, size: 24),
      ),
      label: label,
    );
  }
}
