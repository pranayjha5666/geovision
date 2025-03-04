import 'dart:io';

abstract class OnboardingEvent {}

class SaveOnboardingDataEvent extends OnboardingEvent {
  final File profileImage;
  final String name;
  final String phone;
  final bool hasBusiness;
  final String businessName;
  final String businessCategory;
  final bool hasachievements;
  final List<String> achievements;

  SaveOnboardingDataEvent({
    required this.profileImage,
    required this.name,
    required this.phone,
    required this.hasBusiness,
    required this.businessName,
    required this.businessCategory,
    required this.hasachievements,
    required this.achievements,
  });


}
