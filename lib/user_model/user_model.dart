class UserModel {
  final String uid;
  final String name;
  final String phone;
  final String photoUrl;
  final String? businessName;
  final String? businessCategory;
  final List<String> achievements;

  UserModel({
    required this.uid,
    required this.name,
    required this.phone,
    required this.photoUrl,
    this.businessName,
    this.businessCategory,
    required this.achievements,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'phone': phone,
      'photoUrl': photoUrl ?? '',
      'businessName': businessName ?? '',
      'businessCategory': businessCategory ?? '',
      'achievements': achievements,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      name: map['name'],
      phone: map['phone'],
      photoUrl: map['photoUrl'],
      businessName: map['businessName'],
      businessCategory: map['businessCategory'],
      achievements: List<String>.from(map['achievements'] ?? []),
    );
  }
}
