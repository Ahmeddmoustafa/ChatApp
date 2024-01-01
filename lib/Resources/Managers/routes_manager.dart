// ignore_for_file: prefer_const_constructors

// import 'package:chat_app/Cubit/ChatPage/chat_cubit.dart';
import 'package:chat_app/Cubit/Login/login_cubit.dart';
import 'package:chat_app/Cubit/Register/register_cubit.dart';
import 'package:chat_app/Presentation/Call_View/call_page.dart';
import 'package:chat_app/Presentation/Call_View/calling_page.dart';
import 'package:chat_app/Presentation/auth/auth_gate.dart';
import 'package:chat_app/Presentation/chat_page.dart';
import 'package:chat_app/Resources/Managers/strings_manager.dart';
import 'package:chat_app/Presentation/register.dart';
import 'package:chat_app/Presentation/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Routes {
  static const String mainRoute = '/main';
  static const String apartmentRoute = '/apartment';
  static const String authRoute = '/auth';
  static const String chatRoute = '/chat';
  static const String callRoute = '/call';
  static const String callingRoute = '/calling';

  static const String splashRoute = '/';
  static const String signInRoute = '/signin';
  static const String registerRoute = '/register';
  static const String forgotPasswordRoute = '/forgotPassword';
  static const String storeDetailsRoute = '/store';
  static const String onBoardingRoute = '/onboarding';
  static const String settingsRoute = '/settings';
  static const String homeRoute = "/home";
  static const String detailsRoute = "/details";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.signInRoute:
        {
          return MaterialPageRoute(
              builder: (context) => SafeArea(
                    child: BlocProvider(
                      create: (context) => LoginCubit(),
                      child: const SignInPage(),
                    ),
                  ));
        }
      case Routes.registerRoute:
        {
          return MaterialPageRoute(
            builder: (context) => SafeArea(
              child: BlocProvider(
                create: (context) => RegisterCubit(),
                child: RegisterPage(),
              ),
            ),
          );
        }
      case Routes.authRoute:
        {
          return MaterialPageRoute(
            builder: (context) => SafeArea(
              child: AuthGate(),
            ),
          );
        }
      case Routes.chatRoute:
        {
          return MaterialPageRoute(
            builder: (context) => SafeArea(
              child: ChatPage(),
            ),
          );
        }
      case Routes.callRoute:
        {
          return MaterialPageRoute(
            builder: (context) => SafeArea(child: CallPage()),
          );
        }
      case Routes.callingRoute:
        {
          return MaterialPageRoute(
            builder: (context) => SafeArea(
                child: CallingPage(
              reciever: false,
            )),
          );
        }

      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.noRouteFound),
        ),
        body: Text(AppStrings.noRouteFound),
      ),
    );
  }
}
