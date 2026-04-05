import 'package:flutter_test/flutter_test.dart';
import 'package:satahti/core/models/user_model.dart';

void main() {
  group('AppUser Model Tests', () {
    test('User toMap and fromMap should be consistent', () {
      final user = AppUser(
        uid: '123',
        phone: '0500000000',
        name: 'Test User',
        role: UserRole.customer,
        city: 'Riyadh',
      );

      final map = user.toMap();
      final fromMapUser = AppUser.fromMap(map);

      expect(fromMapUser.uid, user.uid);
      expect(fromMapUser.name, user.name);
      expect(fromMapUser.role, user.role);
      expect(fromMapUser.city, user.city);
    });
  });
}
