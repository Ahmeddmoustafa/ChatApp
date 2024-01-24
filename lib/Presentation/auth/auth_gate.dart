import 'package:chat_app/Cubit/Call/call_cubit.dart';
import 'package:chat_app/Cubit/Login/login_cubit.dart';
import 'package:chat_app/Presentation/Call_View/calling_page.dart';
import 'package:chat_app/Presentation/home_page.dart';
import 'package:chat_app/Presentation/sign_in.dart';
import 'package:chat_app/Resources/Managers/routes_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    final CallCubit callInfo = context.read<CallCubit>();

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // return StreamBuilder<DocumentSnapshot>(
              //     stream: callInfo.openCall(),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasError) {
              //         return Text("Error:  ${snapshot.error}");
              //       }

              //       if (snapshot.hasData && snapshot.data!.exists) {
              //         final String status = snapshot.data!["status"].toString();
              //         print(status);
              //         if (status == "PENDING") {
              //           return const CallingPage(reciever: true);
              //         }
              //         if (status == "ACCEPTED") {
              //           return const HomePage();
              //         }
              //         return const HomePage();
              //       }
              //       return const HomePage();
              //     });
              return const HomePage();
            }
            return const SignInPage();
          }),
    );
  }
}
