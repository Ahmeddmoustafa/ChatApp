import 'package:chat_app/Cubit/Register/register_cubit.dart';
import 'package:chat_app/Resources/Managers/routes_manager.dart';
import 'package:chat_app/Resources/Managers/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  void _register(state) {
    BlocProvider.of<RegisterCubit>(context).register();
    // if (state is LoginLoading) {
    //   Navigator.pushReplacementNamed(context, Routes.mainRoute);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('CHAT'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.s16),
          child: BlocConsumer<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterLoading) {
                Navigator.pushReplacementNamed(context, Routes.authRoute);
              } else if (state is RegisterFailed) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  showCloseIcon: true,
                  content: Text(state.error),
                ));
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(
                      Icons.security,
                      size: AppSize.s100,
                    ),
                    const SizedBox(height: AppSize.s16),
                    TextFormField(
                      controller: context.read<RegisterCubit>().emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        errorText:
                            state is RegisterError ? state.emailError : null,
                      ),
                    ),
                    const SizedBox(height: AppSize.s16),
                    TextFormField(
                      controller:
                          context.read<RegisterCubit>().passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        errorText:
                            state is RegisterError ? state.passError : null,
                      ),
                    ),
                    const SizedBox(height: AppSize.s16),
                    TextFormField(
                      controller: context
                          .read<RegisterCubit>()
                          .confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        errorText: state is RegisterError
                            ? state.confirmPasswordError
                            : null,
                      ),
                    ),
                    const SizedBox(height: AppSize.s16),
                    ElevatedButton(
                      onPressed: () {
                        _register(state);
                      },
                      child: const Text("Register"),
                    ),
                    const SizedBox(height: AppSize.s16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account? ",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacementNamed(
                              context, Routes.signInRoute),
                          child: Text(
                            "Login Now",
                            style: Theme.of(context).textTheme.displayMedium,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}



// //BlocConsumer<LoginCubit, LoginState>(
//         listener: (context, state) {
//           if (state is LoginLoading) {
//             Navigator.pushReplacementNamed(context, Routes.mainRoute);
//           }
//         },
//         builder: (context, state) {
//           return