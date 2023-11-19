import 'package:bloc/bloc.dart';
import 'package:chat_app/Presentation/auth/auth_services.dart';
// import 'package:meta/meta.dart';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
// import 'package:rent_app/Domain/Usecases/renter_usecase.dart';
part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final authservice = AuthService();

  late String email;
  late String password;
  late String confirmPassword;
  late String emailError;
  late String passwordError;
  late String confirmPasswordError;
  RegisterCubit() : super(RegisterInitial());

  void initVariables() {
    email = emailController.text;
    password = passwordController.text;
    confirmPassword = confirmPasswordController.text;
    emailError = "";
    passwordError = "";
    confirmPasswordError = "";
  }

  void register() async {
    emit(RegisterInitial());
    initVariables();
    bool emailerror = false;
    bool passerror = false;
    bool confirmpasserror = false;

    if (!EmailValidator.validate(email)) {
      emailError = "Invalid Email Address";
      emailerror = true;
    }
    if (password.length < 8) {
      passwordError = "Please enter password at least 8 characters";
      passerror = true;
    }
    if (password != confirmPassword) {
      confirmPasswordError = "The two passwords are different";
      confirmpasserror = true;
    }

    if (passerror || emailerror || confirmpasserror) {
      emit(
        RegisterError(
          passError: passerror ? passwordError : null,
          emailError: emailerror ? emailError : null,
          confirmPasswordError: confirmpasserror ? confirmPasswordError : null,
        ),
      );
    }

    if (EmailValidator.validate(email) &&
        password.length >= 8 &&
        !confirmpasserror) {
      // Perform your login/authentication logic here

      // try {
      //   final user =
      //       await getRenter(SignInParams(email: email, password: password));
      // } catch (serverFailure) {
      //   debugPrint("server error");
      try {
        await authservice.signUp(email, password);
        emit(RegisterLoading());
      } catch (err) {
        emit(RegisterFailed(error: err.toString()));
      }

      return;
    }
  }
}
