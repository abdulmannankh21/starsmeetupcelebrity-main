import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import '../models/faq_model.dart';

class PrivacyPolicyService {
  final CollectionReference privacyPoliciesCollection =
      FirebaseFirestore.instance.collection('privacyPolicy');

  Future<List<PoliciesModel>> getPrivacyPolicy() async {
    try {
      QuerySnapshot querySnapshot = await privacyPoliciesCollection
          .orderBy("timestamp", descending: false)
          .get();
      List<PoliciesModel> policies = querySnapshot.docs
          .map((doc) =>
              PoliciesModel.fromMap(doc.id, doc.data() as Map<String, dynamic>))
          .toList();
      return policies;
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading Terms data: $e');
      }
      return [];
    }
  }
}
