import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../widgets/custom_button.dart';
import 'searching_screen.dart';

class UserRegistrationScreen extends StatefulWidget {
  const UserRegistrationScreen({super.key});

  @override
  State<UserRegistrationScreen> createState() => _UserRegistrationScreenState();
}

class _UserRegistrationScreenState extends State<UserRegistrationScreen> {
  int _currentStep = 1;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _carType = 'سيدان';
  String _city = 'الرياض';
  String _locationDesc = '';
  String _breakdownType = 'بطارية فارغة';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('تسجيل المتعطل'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (_currentStep > 1) {
              setState(() => _currentStep--);
            } else {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Column(
        children: [
          _buildStepIndicator(),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: _buildFormContent(),
            ),
          ),
          _buildBottomButtons(),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          _StepDot(isActive: _currentStep >= 1, isDone: _currentStep > 1),
          const SizedBox(width: 8),
          _StepDot(isActive: _currentStep >= 2, isDone: _currentStep > 2),
          const SizedBox(width: 8),
          _StepDot(isActive: _currentStep >= 3, isDone: _currentStep > 3),
        ],
      ),
    );
  }

  Widget _buildFormContent() {
    if (_currentStep == 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('معلوماتك 👤', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          const SizedBox(height: 24),
          _buildField('الاسم الكامل', 'مثال: محمد العمري', _nameController),
          const SizedBox(height: 16),
          _buildField('رقم الجوال', '05XXXXXXXX', _phoneController, keyboardType: TextInputType.phone),
          const SizedBox(height: 16),
          const Text('نوع السيارة', style: TextStyle(color: AppColors.muted, fontSize: 14)),
          const SizedBox(height: 8),
          _buildDropdown(['سيدان', 'SUV', 'بيكب', 'باص', 'أخرى'], _carType, (val) => setState(() => _carType = val!)),
        ],
      );
    } else if (_currentStep == 2) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('موقعك 📍', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          const SizedBox(height: 24),
          const Text('المدينة', style: TextStyle(color: AppColors.muted, fontSize: 14)),
          const SizedBox(height: 8),
          _buildDropdown(['الرياض', 'جدة', 'مكة المكرمة', 'الدمام', 'الخبر', 'المدينة المنورة', 'أبها', 'تبوك'], _city, (val) => setState(() => _city = val!)),
          const SizedBox(height: 16),
          _buildField('وصف موقعك', 'مثال: طريق الملك فهد', null, onChanged: (val) => _locationDesc = val),
          const SizedBox(height: 16),
          const Text('نوع العطل', style: TextStyle(color: AppColors.muted, fontSize: 14)),
          const SizedBox(height: 8),
          _buildDropdown(['بطارية فارغة', 'إطار مثقوب', 'حادث', 'تعطل المحرك', 'نفاد الوقود', 'أخرى'], _breakdownType, (val) => setState(() => _breakdownType = val!)),
        ],
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('تأكيد الطلب ✅', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
          const SizedBox(height: 24),
          _buildConfirmCard(),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: AppColors.border),
            ),
            child: const Text(
              '🔒 بياناتك آمنة ومحمية. سيتم مشاركة موقعك مع أقرب سطحة فقط.',
              style: TextStyle(color: AppColors.muted, fontSize: 13, height: 1.6),
            ),
          ),
        ],
      );
    }
  }

  Widget _buildField(String label, String hint, TextEditingController? controller, {TextInputType? keyboardType, Function(String)? onChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: AppColors.muted, fontSize: 14)),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          onChanged: onChanged,
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

  Widget _buildConfirmCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card2,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        children: [
          _buildInfoRow('الاسم', _nameController.text),
          _buildInfoRow('الجوال', _phoneController.text),
          _buildInfoRow('المدينة', _city),
          _buildInfoRow('نوع العطل', _breakdownType),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.muted, fontSize: 13)),
          Text(value.isEmpty ? '-' : value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          if (_currentStep > 1) ...[
            Expanded(
              flex: 1,
              child: CustomButton(
                text: 'رجوع',
                isPrimary: false,
                onPressed: () => setState(() => _currentStep--),
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            flex: 2,
            child: CustomButton(
              text: _currentStep < 3 ? 'التالي ←' : '🚛 أرسل الطلب',
              onPressed: () {
                if (_currentStep < 3) {
                  setState(() => _currentStep++);
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SearchingScreen(city: _city),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StepDot extends StatelessWidget {
  final bool isActive;
  final bool isDone;

  const _StepDot({required this.isActive, required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 4,
        decoration: BoxDecoration(
          color: isDone
              ? AppColors.success
              : isActive
                  ? AppColors.primary
                  : Colors.white10,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}
