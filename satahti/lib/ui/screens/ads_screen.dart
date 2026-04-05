import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../widgets/custom_button.dart';
import '../widgets/bottom_nav_bar.dart';

class AdsScreen extends StatelessWidget {
  const AdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(currentIndex: 2),
      appBar: AppBar(
        title: const Text('📢 الإعلانات'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderBanner(),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('ترتيب المعلنين · يتجدد يومياً ⏰', style: TextStyle(color: AppColors.muted, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildAdCard('🥇 ورشة النجمة', 'ورشة سيارات · الرياض', 150, '🔧'),
                  _buildAdCard('🥈 مركز الخليج', 'بنشر وإطارات · جدة', 120, '🛞'),
                  _buildAdCard('🥉 ورشة الأمانة', 'كهرباء سيارات · الدمام', 90, '⚡'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderBanner() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.accent.withOpacity(0.15), AppColors.primary.withOpacity(0.1)],
        ),
        border: const Border(bottom: BorderSide(color: Colors.white12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('🏆 تنافس على الصدارة', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
          const SizedBox(height: 6),
          const Text(
            'الأعلى مزايدة يومياً يحصل على أعلى مكان في التطبيق. كلما دفعت أكثر، ظهرت أولاً أمام آلاف المستخدمين المتعطلين.',
            style: TextStyle(color: AppColors.muted, fontSize: 13, height: 1.7),
          ),
          const SizedBox(height: 20),
          CustomButton(
            text: '➕ أضف إعلانك الآن',
            onPressed: () {},
            isPrimary: false,
          ),
        ],
      ),
    );
  }

  Widget _buildAdCard(String title, String subtitle, int bid, String icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card2,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 52, height: 52,
                decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.12), borderRadius: BorderRadius.circular(14)),
                alignment: Alignment.center,
                child: Text(icon, style: const TextStyle(fontSize: 26)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.muted)),
                  ],
                ),
              ),
              Column(
                children: [
                  Text('$bid', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: AppColors.primary)),
                  const Text('ريال/يوم', style: TextStyle(fontSize: 10, color: AppColors.muted)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: CustomButton(text: '📞 تواصل', isPrimary: false, onPressed: () {}),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 2,
                child: CustomButton(text: '⬆️ زايد على مكانه', onPressed: () {}),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
