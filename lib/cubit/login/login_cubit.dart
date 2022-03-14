import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:max_flutter_authentication/repositories/auth_repository.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _authRepository;
  LoginCubit(this._authRepository) : super(LoginState.initial());

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: LoginStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: LoginStatus.initial));
  }

  Future<void> loginWithCredentials() async {
    if (state.status == LoginStatus.submitting) return;
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      await _authRepository.logInWithEmailAndPassword(email: state.email, password: state.password);
      emit(state.copyWith(status: LoginStatus.success));
    } on FirebaseAuthException catch (e) {

      String message = "Email or password is incorrect";
      if (e.code == 'invalid-email') {
        message = 'The email provided is incorrect format.';
      } 
       else if (e.code == 'user-not-found') {
        message = 'No user found for this email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user';
      }else if (e.code == 'user-disabled') {
        message = 'This user disabled due to privacy';
      }
      emit(state.copyWith(errorMessage: message, status: LoginStatus.error));
    } catch (e) {
      print("Login error: $e");
      emit(state.copyWith(errorMessage: "Something wrong...",status: LoginStatus.error));
    }
  }
}
