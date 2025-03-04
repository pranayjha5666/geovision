class LocationModel {
  final String name;
  final String latitude;
  final String longitude;

  LocationModel({required this.name, required this.latitude, required this.longitude});

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      name: map['location'] ?? '',
      latitude: map['lat'] ?? '',
      longitude: map['long'] ?? '',
    );
  }
}
