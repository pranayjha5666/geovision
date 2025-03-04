import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geovision/features/onboarding/data/cloudinaryservices.dart';
import 'package:geovision/user_model/user_model.dart';

class OnboardingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CloudinaryServices _cloudinaryService;

  OnboardingRepository(
    CloudinaryServices cloudinaryService,
  ) : _cloudinaryService = cloudinaryService;

  Future<void> saveUserData({
    required File profileImage,
    required String name,
    required String phone,
    required bool hasBusiness,
    String? businessName,
    String? businessCategory,
    required bool hasachievements,
    required List<String> achievements,
  }) async {
    try {
      final String? uid = _auth.currentUser?.uid;
      if (uid == null) throw Exception('User not authenticated');

      final String? photoUrl =
          await _cloudinaryService.uploadImageToCloudinary(profileImage, uid);
      final UserModel user = UserModel(
        uid: uid,
        name: name,
        phone: phone,
        photoUrl: photoUrl!,
        businessName: hasBusiness ? businessName : null,
        businessCategory: hasBusiness ? businessCategory : null,
        achievements: hasachievements ? achievements : [],
      );
      await _firestore.collection('users').doc(uid).set(user.toMap());
    } catch (e) {
      throw Exception('Failed to save user data: $e');
    }
  }
}
