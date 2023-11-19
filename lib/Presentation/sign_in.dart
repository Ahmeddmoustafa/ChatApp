import 'package:chat_app/Cubit/Login/login_cubit.dart';
import 'package:chat_app/Resources/Managers/routes_manager.dart';
import 'package:chat_app/Resources/Managers/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  void _login(state) {
    BlocProvider.of<LoginCubit>(context).login();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CHAT'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSize.s16),
          child: BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginLoading) {
                Navigator.pushReplacementNamed(context, Routes.authRoute);
              } else if (state is LoginFailed) {
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
                      controller: context.read<LoginCubit>().emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        errorText:
                            state is LoginError ? state.emailError : null,
                      ),
                    ),
                    const SizedBox(height: AppSize.s16),
                    TextFormField(
                      controller: context.read<LoginCubit>().passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        errorText: state is LoginError ? state.passError : null,
                      ),
                    ),
                    const SizedBox(height: AppSize.s16),
                    ElevatedButton(
                      onPressed: () {
                        _login(state);
                      },
                      child: const Text("Login"),
                    ),
                    const SizedBox(height: AppSize.s16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacementNamed(
                              context, Routes.registerRoute),
                          child: Text(
                            "Register Now",
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