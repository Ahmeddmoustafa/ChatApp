import 'package:chat_app/Cubit/Call/call_cubit.dart';
import 'package:chat_app/Resources/Managers/assets_manager.dart';
import 'package:chat_app/Resources/Managers/colors_manager.dart';
import 'package:chat_app/Resources/Managers/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

class CallingPage extends StatelessWidget {
  final bool reciever;
  const CallingPage({super.key, required this.reciever});

  void ring() async {
    // final AudioPlayer player = AudioPlayer();
    // if (reciever) {
    //   await player.setAsset(AssetsManager.RingTone);

    //   await player.play();
    // }
  }

  @override
  Widget build(BuildContext context) {
    final CallCubit callInfo = BlocProvider.of<CallCubit>(context);
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final TextTheme textTheme = Theme.of(context).textTheme;
    ring();
    return Scaffold(
        // backgroundColor: ColorManager.LightGrey,
        body: Center(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
            colors: [
              ColorManager.PrimaryColor,
              ColorManager.PrimaryColor,
              ColorManager.PrimaryColor,
              ColorManager.DarkBlue,
            ],
          ),
        ),
        child: SizedBox(
          height: height * 0.6,
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Unknown",
                style: textTheme.displayLarge,
              ),
              Text(
                "Email@gmail.com",
                style: textTheme.displayLarge,
              ),
              Icon(
                Icons.account_circle,
                color: ColorManager.LightSilver,
                size: 150,
              ),
              Text(
                "CALLING!!!",
                style: textTheme.displayLarge,
              ),
              !reciever
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Icon(
                              Icons.alarm,
                              color: ColorManager.White,
                            ),
                            Text(
                              "REMIND ME",
                              style: textTheme.bodySmall,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Icon(
                              Icons.message,
                              color: ColorManager.White,
                            ),
                            Text(
                              "MESSAGE",
                              style: textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
              Row(
                mainAxisAlignment: !reciever
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceEvenly,
                children: [
                  reciever
                      ? TextButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(ColorManager.Green)),
                          child: Icon(
                            Icons.call_outlined,
                            color: ColorManager.White,
                          ),
                        )
                      : const SizedBox.shrink(),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(ColorManager.error)),
                    onPressed: () async {
                      // await callInfo.endCall();
                      if (context.mounted) {
                        Navigator.pushReplacementNamed(
                            context, Routes.authRoute);
                      }
                    },
                    child: Icon(
                      Icons.call_end,
                      color: ColorManager.White,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    )
        //  Center(
        //     child: Column(
        //       children: [
        //         const Text("CALLING!!!"),
        //         TextButton(
        //           onPressed: () {},
        //           style: ButtonStyle(
        //               backgroundColor:
        //                   MaterialStatePropertyAll(ColorManager.Blue)),
        //           child: const Text("ACCEPT"),
        //         ),
        //         TextButton(
        //           onPressed: () async {
        //             // await callInfo.endCall();
        //             if (context.mounted) {
        //               Navigator.pushReplacementNamed(
        //                   context, Routes.authRoute);
        //             }
        //           },
        //           style: ButtonStyle(
        //               backgroundColor:
        //                   MaterialStatePropertyAll(ColorManager.error)),
        //           child: const Text("CANCEL"),
        //         )
        //       ],
        //     ),
        //   ),
        );
  }
}
