part of'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String error;
  AuthFailure({required this.error});
}

class AuthEmailVerificationSent extends AuthState{}

class AuthisAlreadyLoggedIn extends AuthState{}

class AuthNotAlreadyLoggedIn extends AuthState{}

class AuthNeedsOnboarding extends AuthState {}



class AuthLoggedOut extends AuthState {}
