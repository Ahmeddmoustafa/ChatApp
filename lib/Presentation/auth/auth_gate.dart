import 'package:chat_app/Cubit/Call/call_cubit.dart';
import 'package:chat_app/Cubit/Login/login_cubit.dart';
import 'package:chat_app/Presentation/Call_View/calling_page.dart';
import 'package:chat_app/Presentation/home_page.dart';
import 'package:chat_app/Presentation/sign_in.dart';
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
    final CallCubit callInfo = BlocProvider.of<CallCubit>(context);

    return BlocProvider(
      create: (context) => LoginCubit(),
      child: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return StreamBuilder<QuerySnapshot>(
                  stream: callInfo.openCall(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                      print(snapshot.data!.docs.last["status"].toString());
                      if (snapshot.data!.docs.last["status"].toString() ==
                          "PENDING") {
                        print("page should be returned");
                        return const CallingPage(reciever: true);
                      }
                      if (snapshot.data!.docs.last["status"].toString() ==
                          "ACCEPTED") {
                        return const HomePage();
                      }
                    }
                    return const HomePage();
                  });
              // return const HomePage();
            }
            return const SignInPage();
          }),
    );
  }
}
