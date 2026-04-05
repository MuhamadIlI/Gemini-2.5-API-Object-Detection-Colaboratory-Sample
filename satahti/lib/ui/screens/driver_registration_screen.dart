import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../widgets/custom_button.dart';
import 'driver_dashboard_screen.dart';

class DriverRegistrationScreen extends StatefulWidget {
  const DriverRegistrationScreen({super.key});

  @override
  State<DriverRegistrationScreen> createState() => _DriverRegistrationScreenState();
}

class _DriverRegistrationScreenState extends State<DriverRegistrationScreen> {
  String _truckType = 'سطحة صغيرة (سيارة)';
  String _city = 'الرياض';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('تسجيل صاحب السطحة'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('بيانات السطحة 🚛', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
            const SizedBox(height: 20),
            _buildField('اسم السائق', 'مثال: خالد العتيبي'),
            const SizedBox(height: 16),
            _buildField('رقم الجوال', '05XXXXXXXX', keyboardType: TextInputType.phone),
            const SizedBox(height: 16),
            _buildLabel('نوع السطحة'),
            _buildDropdown(['سطحة صغيرة (سيارة)', 'سطحة متوسطة (SUV/بيكب)', 'سطحة كبيرة (شاحنة)'], _truckType, (val) => setState(() => _truckType = val!)),
            const SizedBox(height: 16),
            _buildField('رقم اللوحة', 'ABC 1234'),
            const SizedBox(height: 16),
            _buildField('رقم رخصة القيادة', 'XXXXXXXXXX'),
            const SizedBox(height: 16),
            _buildLabel('منطقة العمل'),
            _buildDropdown(['الرياض', 'جدة', 'مكة المكرمة', 'الدمام', 'الخبر'], _city, (val) => setState(() => _city = val!)),
            const SizedBox(height: 32),
            CustomButton(
              text: '🚛 سجل كسائق',
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const DriverDashboardScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(label, style: const TextStyle(color: AppColors.muted, fontSize: 14)),
    );
  }

  Widget _buildField(String label, String hint, {TextInputType? keyboardType}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        TextField(
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: AppColors.card2,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown(List<String> items, String value, Function(String?) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.card2,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: AppColors.card2,
          items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
