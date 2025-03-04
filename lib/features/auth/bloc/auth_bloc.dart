import 'package:bloc/bloc.dart';
import 'package:geovision/features/auth/data/repositories/auth_repository.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthRepository _authRepository ;

  AuthBloc(this._authRepository) : super(AuthInitial()) {

    on<AuthSignUpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authRepository.signUp(event.email, event.password);
        emit(AuthEmailVerificationSent());
      } catch (e) {
        emit(AuthFailure(error: e.toString()));
      }
    });

    on<AuthSignInEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final isonboarding = await _authRepository.signIn(event.email, event.password);
        if(isonboarding=="yes") emit(AuthSuccess());
        else emit(AuthNeedsOnboarding());
      } catch (e) {
        emit(AuthFailure(error: getFirebaseErrorMessage(e.toString())));
      }
    });

    on<AuthGoogleSignintEvent>((event,emit)async{
      emit(AuthLoading());
      try{
        final isonboarding =await _authRepository.handleGoogleSign();
        if(isonboarding=="yes") emit(AuthSuccess());
        else emit(AuthNeedsOnboarding());      }
      catch(e){
        emit(AuthFailure(error: e.toString()));
      }
    });


    on<AuthCheckStatus>((event,emit)async {
      final user=await _authRepository.checkauthstatus();
      if(user=="null"){
        emit(AuthNotAlreadyLoggedIn());
        return;
      }
      else if(user=="yes"){
        emit(AuthisAlreadyLoggedIn());
        return;
      }
      else if(user=="no"){
        emit(AuthNeedsOnboarding());
        return;
      }    });

    on<AuthSignOutEvent>((event, emit) async {
      emit(AuthLoading());
      await _authRepository.signOut();
      emit(AuthLoggedOut());
    });


  }


  String getFirebaseErrorMessage(String errorCode) {
    print("Hii: $errorCode");
    switch (errorCode) {
      case "invalid-credential":
        return 'Invalid email address or password.';
      case 'user-disabled':
        return 'This user account has been disabled.';
      case 'user-not-found':
        return 'No user found with this email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      case 'account-exists-with-different-credential':
        return 'An account already exists with this email but a different sign-in method.';
      default:
        return 'An unexpected error occurred. Please try again.';
    }
  }
}
