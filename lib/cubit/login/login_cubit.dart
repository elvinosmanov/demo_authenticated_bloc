import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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

  Future<void> loginWithCredentials(String email, String password) async {
    if (state.status == LoginStatus.submitting) return;
    emit(state.copyWith(status: LoginStatus.submitting));
    try {
      await _authRepository.logInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      print(e);
      emit(state.copyWith(status: LoginStatus.error));
    }
  }
}
