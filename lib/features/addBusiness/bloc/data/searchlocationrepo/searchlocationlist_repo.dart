import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geovision/user_model/location_model.dart';

class SearchlocationlistRepo {
  Future<List<LocationModel>> fetchLocations() async {
    try {
      // Simulate API call (Replace with actual API request)
      final snapshot =
          await FirebaseFirestore.instance.collection('locationdata').get();

      return snapshot.docs.map((doc) {
        return LocationModel(
          name: doc['location'] ?? "Unknown",
          latitude: (doc['lat'] ?? 0),
          longitude: (doc['long'] ?? 0),
        );
      }).toList();
    } catch (e) {
      throw Exception("Failed to fetch locations");
    }
  }
}
