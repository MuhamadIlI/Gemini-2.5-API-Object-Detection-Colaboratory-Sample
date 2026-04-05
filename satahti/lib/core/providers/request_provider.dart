import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/request_model.dart';

class RequestProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TowRequest? _activeRequest;
  TowRequest? get activeRequest => _activeRequest;

  Future<void> createRequest(TowRequest request) async {
    await _firestore.collection('requests').doc(request.id).set(request.toMap());
    _activeRequest = request;
    notifyListeners();

    // Listen for changes
    _firestore.collection('requests').doc(request.id).snapshots().listen((snapshot) {
      if (snapshot.exists) {
        _activeRequest = TowRequest.fromMap(snapshot.data() as Map<String, dynamic>);
        notifyListeners();
      }
    });
  }

  Future<void> updateRequestStatus(String id, String status) async {
    await _firestore.collection('requests').doc(id).update({'status': status});
  }

  Future<void> cancelRequest(String id) async {
    await updateRequestStatus(id, 'cancelled');
    _activeRequest = null;
    notifyListeners();
  }
}
