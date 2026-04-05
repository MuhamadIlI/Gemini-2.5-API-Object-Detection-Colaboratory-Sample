import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/bottom_nav_bar.dart';
import '../../core/routes.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(currentIndex: 0),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.0,
            colors: [
              Color(0xFF1A0A00),
              AppColors.bg,
            ],
            stops: [0.0, 0.7],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 3),
            _buildLogo(context),
            const Spacer(flex: 2),
            _buildButtons(context),
            const SizedBox(height: 30),
            const Text(
              'منصة آمنة · 24/7 · أسرع استجابة',
              style: TextStyle(color: AppColors.muted, fontSize: 13),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onLongPress: () {
            Navigator.pushNamed(context, AppRoutes.admin);
          },
          child: const Text(
            '🚛',
            style: TextStyle(fontSize: 80, shadows: [
              Shadow(
                color: AppColors.primary,
                blurRadius: 40,
              )
            ]),
          ),
        ),
        const SizedBox(height: 16),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [AppColors.primary, AppColors.accent],
          ).createShader(bounds),
          child: const Text(
            'سطحتي',
            style: TextStyle(
              fontSize: 52,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
        const Text(
          'مساعدة على الطريق · أسرع سطحة',
          style: TextStyle(
            color: AppColors.muted,
            fontSize: 16,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              text: 'ابدأ الآن 🚀',
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.roleSelection);
              },
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              text: 'لدي حساب بالفعل',
              isOutline: true,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const RoleSelectionScreen()),
                );
              },
            ),
          ),
          const SizedBox(height: 14),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFD700), Color(0xFFFF8C00)],
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: CustomButton(
              text: '📢 أعلن معنا',
              isPrimary: false,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
