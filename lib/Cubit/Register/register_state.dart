// ignore_for_file: prefer_typing_uninitialized_variables

part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterFailed extends RegisterState {
  final String error;

  RegisterFailed({required this.error});
}

final class RegisterLoading extends RegisterState {}

final class RegisterError extends RegisterState {
  final passError;
  final emailError;
  final confirmPasswordError;

  RegisterError(
      {required this.passError,
      required this.emailError,
      required this.confirmPasswordError});

  get getPassError => passError;
  get getConfirmPassError => confirmPasswordError;

  get getEmailError => emailError;
}
