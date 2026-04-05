import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/request_model.dart';

class DriverProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<TowRequest> _nearbyRequests = [];
  List<TowRequest> get nearbyRequests => _nearbyRequests;

  bool _isOnline = false;
  bool get isOnline => _isOnline;

  void toggleOnline(String driverId, bool status) async {
    _isOnline = status;
    await _firestore.collection('users').doc(driverId).update({
      'isOnline': status,
    });
    notifyListeners();

    if (status) {
      _listenForRequests();
    }
  }

  void _listenForRequests() {
    _firestore
        .collection('requests')
        .where('status', isEqualTo: 'searching')
        .snapshots()
        .listen((snapshot) {
      _nearbyRequests = snapshot.docs.map((doc) => TowRequest.fromMap(doc.data())).toList();
      notifyListeners();
    });
  }

  Future<void> acceptRequest(String requestId, String driverId) async {
    await _firestore.collection('requests').doc(requestId).update({
      'status': 'matched',
      'driverId': driverId,
    });
  }
}
