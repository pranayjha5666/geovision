part of'auth_bloc.dart';

abstract class AuthEvent {}

class AuthSignUpEvent extends AuthEvent {
  final String email;
  final String password;
  AuthSignUpEvent({required this.email, required this.password});
}

class AuthSignInEvent extends AuthEvent {
  final String email;
  final String password;
  AuthSignInEvent({required this.email, required this.password});
}


class AuthGoogleSignintEvent extends AuthEvent {}

class AuthCheckStatus extends AuthEvent {}

class AuthSignOutEvent extends AuthEvent {}
