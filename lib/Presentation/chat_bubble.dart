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
          top: AppSize.s8, left: AppSize.s8, right: AppSize.s8),
      padding: const EdgeInsets.symmetric(
          horizontal: AppSize.s20, vertical: AppSize.s4),
      decoration: BoxDecoration(
        color: sender ? ColorManager.LightGreen : ColorManager.LightGrey,
        borderRadius: BorderRadius.only(
          topRight: sender ? Radius.zero : const Radius.circular(AppSize.s10),
          topLeft: sender ? const Radius.circular(AppSize.s10) : Radius.zero,
          bottomLeft: const Radius.circular(AppSize.s10),
          bottomRight: const Radius.circular(AppSize.s10),
        ),
      ),
      child: Text(
        message,
        style: TextStyle(color: ColorManager.White),
      ),
    );
  }
}
