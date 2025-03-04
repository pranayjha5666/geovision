import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geovision/features/onboarding/data/onboarding_repository.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final OnboardingRepository _repository;
  OnboardingBloc(this._repository):super(OnboardingInitial()) {
    on<SaveOnboardingDataEvent>((event,emit)async{
      emit(OnboardingLoading());
      try{
        await _repository.saveUserData(profileImage: event.profileImage, name: event.name, phone: event.phone, hasBusiness: event.hasBusiness, hasachievements: event.hasachievements, achievements: event.achievements);
        emit( OnboardingSuccess());
      }catch (e) {
        emit(OnboardingFailure(error: e.toString()));
      }

    });
  }

  Future<void> _handleSaveOnboarding(
      SaveOnboardingDataEvent event,
      Emitter<OnboardingState> emit,
      ) async {
    try {
      print("Onboarding Started...");
      emit(OnboardingLoading());
      print("Waiting Started");
      await _repository.saveUserData(profileImage: event.profileImage, name: event.name, phone: event.phone, hasBusiness: event.hasBusiness, hasachievements: event.hasachievements, achievements: event.achievements);
      emit( OnboardingSuccess());
      print("Done");
    } catch (e) {
      emit(OnboardingFailure(error: e.toString()));
    }
  }
}


