import 'package:chat_app/Resources/Managers/colors_manager.dart';
import 'package:chat_app/Resources/Managers/values_manager.dart';
import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool sender;
  const ChatBubble({super.key, required this.message, required this.sender});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
          top: AppSize.s4, left: AppSize.s4, right: AppSize.s4),
      padding: const EdgeInsets.symmetric(
          horizontal: AppSize.s20, vertical: AppSize.s4),
      decoration: BoxDecoration(
        color: sender ? ColorManager.Blue : ColorManager.DarkGrey,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Text(
        message,
        style: TextStyle(color: ColorManager.White),
      ),
    );
  }
}
