import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../widgets/bottom_nav_bar.dart';

class SupportScreen extends StatefulWidget {
  const SupportScreen({super.key});

  @override
  State<SupportScreen> createState() => _SupportScreenState();
}

class _SupportScreenState extends State<SupportScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const BottomNavBar(currentIndex: 3),
      appBar: AppBar(
        title: const Text('🎧 الدعم الفني'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: '💬 شات'),
            Tab(text: '❓ أسئلة شائعة'),
            Tab(text: '📋 مشكلة'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildChatTab(),
          _buildFaqTab(),
          _buildTicketTab(),
        ],
      ),
    );
  }

  Widget _buildChatTab() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildMessage('أهلاً! كيف يمكنني مساعدتك اليوم؟ 😊', isAgent: true),
            ],
          ),
        ),
        _buildChatInput(),
      ],
    );
  }

  Widget _buildMessage(String text, {required bool isAgent}) {
    return Align(
      alignment: isAgent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isAgent ? AppColors.card2 : AppColors.primary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(text),
      ),
    );
  }

  Widget _buildChatInput() {
    return Container(
      padding: const EdgeInsets.all(12),
      color: AppColors.card,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'اكتب رسالتك...',
                fillColor: AppColors.card2,
                filled: true,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.send, color: AppColors.primary),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildFaqTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildFaqItem('كيف أطلب سطحة؟', 'اضغط زر 🆘 في الأسفل، ثم أدخل بياناتك وموقعك ونوع العطل، وسنجد لك أقرب سطحة في دقائق.'),
        _buildFaqItem('كيف يتم الدفع؟', 'الدفع مباشرة بين المتعطل وصاحب السطحة بعد الاتفاق على السعر. المنصة تأخذ 1% فقط كعمولة خدمة.'),
      ],
    );
  }

  Widget _buildFaqItem(String q, String a) {
    return ExpansionTile(
      title: Text(q, style: const TextStyle(fontWeight: FontWeight.bold)),
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(a, style: const TextStyle(color: AppColors.muted)),
        )
      ],
    );
  }

  Widget _buildTicketTab() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          TextField(decoration: const InputDecoration(labelText: 'الاسم')),
          const SizedBox(height: 16),
          TextField(decoration: const InputDecoration(labelText: 'رقم الجوال')),
          const SizedBox(height: 16),
          TextField(
            maxLines: 4,
            decoration: const InputDecoration(labelText: 'وصف المشكلة'),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
            child: const Text('📤 إرسال المشكلة'),
          ),
        ],
      ),
    );
  }
}
