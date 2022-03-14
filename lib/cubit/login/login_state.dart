part of 'login_cubit.dart';

enum LoginStatus { initial, submitting, success, error }

@immutable
class LoginState extends Equatable {
  final String email;
  final String password;
  final LoginStatus status;
  final String errorMessage;

  const LoginState({
    required this.email,
    required this.password,
    required this.status,
    required this.errorMessage,
  });

  factory LoginState.initial() {
    return const LoginState(email: "", password: "", errorMessage: "", status: LoginStatus.initial);
  }

  @override
  List<Object?> get props => [email, password, status, errorMessage];

  LoginState copyWith({
    String? email,
    String? password,
    LoginStatus? status,
    String? errorMessage,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
