import 'package:chat_app/Cubit/Call/call_cubit.dart';
import 'package:chat_app/Resources/Managers/colors_manager.dart';
import 'package:chat_app/Resources/Managers/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CallingPage extends StatelessWidget {
  final bool reciever;
  const CallingPage({super.key, required this.reciever});

  @override
  Widget build(BuildContext context) {
    final CallCubit callInfo = BlocProvider.of<CallCubit>(context);
    return Scaffold(
      body: !reciever
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("CALLING!!!"),
                  TextButton(
                    onPressed: () async {
                      await callInfo.endCall();
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(
                            context, Routes.authRoute);
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(ColorManager.error)),
                    child: const Text("CANCEL"),
                  )
                ],
              ),
            )
          : Center(
              child: Column(
                children: [
                  const Text("CALLING!!!"),
                  TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(ColorManager.Blue)),
                    child: const Text("ACCEPT"),
                  ),
                  TextButton(
                    onPressed: () async {
                      await callInfo.endCall();
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(
                            context, Routes.authRoute);
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(ColorManager.error)),
                    child: const Text("CANCEL"),
                  )
                ],
              ),
            ),
    );
  }
}
