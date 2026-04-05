class AppUser {
  final String uid;
  final String phone;
  final String name;
  final UserRole role;
  final String? carType;
  final String? city;
  final String? truckType;
  final String? plateNumber;
  final bool isApproved;

  AppUser({
    required this.uid,
    required this.phone,
    required this.name,
    required this.role,
    this.carType,
    this.city,
    this.truckType,
    this.plateNumber,
    this.isApproved = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'phone': phone,
      'name': name,
      'role': role.toString().split('.').last,
      'carType': carType,
      'city': city,
      'truckType': truckType,
      'plateNumber': plateNumber,
      'isApproved': isApproved,
    };
  }

  factory AppUser.fromMap(Map<String, dynamic> map) {
    return AppUser(
      uid: map['uid'] ?? '',
      phone: map['phone'] ?? '',
      name: map['name'] ?? '',
      role: UserRole.values.firstWhere(
        (e) => e.toString().split('.').last == map['role'],
        orElse: () => UserRole.customer,
      ),
      carType: map['carType'],
      city: map['city'],
      truckType: map['truckType'],
      plateNumber: map['plateNumber'],
      isApproved: map['isApproved'] ?? false,
    );
  }
}

enum UserRole {
  customer,
  driver,
  admin,
}
