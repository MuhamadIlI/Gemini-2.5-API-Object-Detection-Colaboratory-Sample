import 'package:cloud_firestore/cloud_firestore.dart';

class TowRequest {
  final String id;
  final String customerId;
  final String customerName;
  final String customerPhone;
  final String carType;
  final String breakdownType;
  final String city;
  final String locationDesc;
  final GeoPoint customerLocation;
  final String status; // searching, matched, negotiating, completed, cancelled
  final String? driverId;
  final double? agreedPrice;
  final DateTime createdAt;

  TowRequest({
    required this.id,
    required this.customerId,
    required this.customerName,
    required this.customerPhone,
    required this.carType,
    required this.breakdownType,
    required this.city,
    required this.locationDesc,
    required this.customerLocation,
    required this.status,
    this.driverId,
    this.agreedPrice,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerId': customerId,
      'customerName': customerName,
      'customerPhone': customerPhone,
      'carType': carType,
      'breakdownType': breakdownType,
      'city': city,
      'locationDesc': locationDesc,
      'customerLocation': customerLocation,
      'status': status,
      'driverId': driverId,
      'agreedPrice': agreedPrice,
      'createdAt': createdAt,
    };
  }

  factory TowRequest.fromMap(Map<String, dynamic> map) {
    return TowRequest(
      id: map['id'] ?? '',
      customerId: map['customerId'] ?? '',
      customerName: map['customerName'] ?? '',
      customerPhone: map['customerPhone'] ?? '',
      carType: map['carType'] ?? '',
      breakdownType: map['breakdownType'] ?? '',
      city: map['city'] ?? '',
      locationDesc: map['locationDesc'] ?? '',
      customerLocation: map['customerLocation'],
      status: map['status'] ?? 'searching',
      driverId: map['driverId'],
      agreedPrice: map['agreedPrice']?.toDouble(),
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }
}
