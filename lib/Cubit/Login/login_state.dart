// ignore_for_file: prefer_typing_uninitialized_variables

part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

//
final class LoginFailed extends LoginState {
  final error;
  LoginFailed({required this.error});
}

final class LoginError extends LoginState {
  final passError;
  final emailError;

  LoginError({required this.passError, required this.emailError});

  get getPassError => passError;
  get getEmailError => emailError;
}

// final class LoginEmailError extends LoginState {
//   final _emailError;

//   const LoginEmailError(this._emailError);

//   get emailError => _emailError;
// }

// final class LoginPassError extends LoginState {
//   final _passError;

//   const LoginPassError(this._passError);

//   get passError => _passError;
// }
