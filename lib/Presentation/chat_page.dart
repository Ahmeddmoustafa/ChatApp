import 'package:chat_app/Cubit/Call/call_cubit.dart';
import 'package:chat_app/Cubit/ChatPage/chat_cubit.dart';
import 'package:chat_app/Presentation/chat_bubble.dart';
import 'package:chat_app/Resources/Managers/colors_manager.dart';
import 'package:chat_app/Resources/Managers/routes_manager.dart';
import 'package:chat_app/Resources/Managers/values_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controller = TextEditingController();
  void sendMessage() {
    if (controller.text.isNotEmpty) {
      BlocProvider.of<ChatCubit>(context).sendMessage(controller.text);
    }
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final chatinfo = BlocProvider.of<ChatCubit>(context);
    final callinfo = BlocProvider.of<CallCubit>(context);

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: ColorManager.White,
          ),
        ),
        title: Text(chatinfo.recieverName),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.callingRoute);
              // await callinfo.callUser(chatinfo.recieverUid, chatinfo.recieverEmail);
            },
            child: Padding(
              padding: const EdgeInsets.only(right: AppSize.s10),
              child: Icon(
                Icons.call,
                color: ColorManager.White,
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                    stream: chatinfo.getMessages(
                        FirebaseAuth.instance.currentUser!.uid,
                        chatinfo.recieverUid),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("Error:  ${snapshot.error}");
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      }
                      return ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return getMessageItem(snapshot.data!.docs[index]);
                          });
                    }),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: AppSize.s4, bottom: AppSize.s4),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller,
                        obscureText: false,
                        decoration: const InputDecoration(
                          hintText: "Enter Your Message",
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        sendMessage();
                      },
                      icon: const Icon(
                        Icons.send,
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget getMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = FirebaseAuth.instance.currentUser!.uid == data["senderId"]
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: ChatBubble(
        message: data["message"],
        sender: alignment == Alignment.centerRight,
      ),
    );
  }
}
