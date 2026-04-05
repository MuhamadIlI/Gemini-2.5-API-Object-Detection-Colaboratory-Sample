import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../routes.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFB141423),
        border: Border(top: BorderSide(color: Colors.white10)),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.muted,
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == currentIndex) return;

          String route = AppRoutes.splash;
          switch (index) {
            case 0: route = AppRoutes.splash; break;
            case 1: route = AppRoutes.driverDashboard; break;
            case 2: route = AppRoutes.ads; break;
            case 3: route = AppRoutes.support; break;
          }
          Navigator.pushReplacementNamed(context, route);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.local_shipping), label: 'السائق'),
          BottomNavigationBarItem(icon: Icon(Icons.campaign), label: 'الإعلانات'),
          BottomNavigationBarItem(icon: Icon(Icons.support_agent), label: 'الدعم'),
        ],
      ),
    );
  }
}
