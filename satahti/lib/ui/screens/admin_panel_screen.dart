import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/theme/app_colors.dart';
import '../../core/models/user_model.dart';
import '../../core/models/request_model.dart';

class AdminPanelScreen extends StatefulWidget {
  const AdminPanelScreen({super.key});

  @override
  State<AdminPanelScreen> createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('لوحة التحكم - أدمن'),
        backgroundColor: AppColors.secondary,
      ),
      body: Row(
        children: [
          _buildSidebar(),
          Expanded(child: _buildContent()),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 200,
      color: AppColors.card,
      child: ListView(
        children: [
          _buildNavItem(0, '📊 نظرة عامة', Icons.dashboard),
          _buildNavItem(1, '🚛 السائقون', Icons.local_shipping),
          _buildNavItem(2, '🆘 الطلبات', Icons.list_alt),
          _buildNavItem(3, '📩 الرسائل', Icons.message),
          _buildNavItem(4, '📢 الإعلانات', Icons.campaign),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: _selectedIndex == index ? AppColors.primary : Colors.grey),
      title: Text(title, style: TextStyle(color: _selectedIndex == index ? AppColors.primary : Colors.white70)),
      selected: _selectedIndex == index,
      onTap: () => setState(() => _selectedIndex = index),
    );
  }

  Widget _buildContent() {
    switch (_selectedIndex) {
      case 0:
        return _buildOverview();
      case 1:
        return _buildDriversList();
      case 2:
        return _buildRequestsList();
      default:
        return const Center(child: Text('قريباً...'));
    }
  }

  Widget _buildOverview() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('نظرة عامة', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 24),
          Row(
            children: [
              _buildStatCard('3,241', 'إجمالي المستخدمين', AppColors.primary),
              _buildStatCard('847', 'طلبات اليوم', AppColors.success),
              _buildStatCard('12,400', 'إيراد الأسبوع', AppColors.accent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String val, String label, Color color) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: AppColors.card2, borderRadius: BorderRadius.circular(18)),
        child: Column(
          children: [
            Text(val, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color)),
            Text(label, style: const TextStyle(color: AppColors.muted)),
          ],
        ),
      ),
    );
  }

  Widget _buildRequestsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('requests').orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final requests = snapshot.data!.docs.map((doc) => TowRequest.fromMap(doc.data() as Map<String, dynamic>)).toList();

        return ListView.builder(
          itemCount: requests.length,
          itemBuilder: (context, index) {
            final req = requests[index];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: AppColors.card2,
              child: ListTile(
                title: Text('${req.customerName} - ${req.carType}'),
                subtitle: Text('الحالة: ${req.status} - ${req.city}'),
                trailing: Text('${req.agreedPrice ?? 0} ريال'),
                onTap: () {
                  // Show details or contact logic
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDriversList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').where('role', isEqualTo: 'driver').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final drivers = snapshot.data!.docs.map((doc) => AppUser.fromMap(doc.data() as Map<String, dynamic>)).toList();

        return ListView.builder(
          itemCount: drivers.length,
          itemBuilder: (context, index) {
            final driver = drivers[index];
            return ListTile(
              leading: const CircleAvatar(child: Text('🚛')),
              title: Text(driver.name),
              subtitle: Text('${driver.truckType} - ${driver.city}'),
              trailing: Switch(
                value: driver.isApproved,
                onChanged: (val) {
                  FirebaseFirestore.instance.collection('users').doc(driver.uid).update({'isApproved': val});
                },
                activeColor: AppColors.success,
              ),
            );
          },
        );
      },
    );
  }
}
