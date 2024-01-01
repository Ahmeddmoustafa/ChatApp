import 'package:chat_app/Cubit/ChatPage/chat_cubit.dart';
import 'package:chat_app/Presentation/auth/auth_services.dart';
import 'package:chat_app/Resources/Managers/colors_manager.dart';
import 'package:chat_app/Resources/Managers/routes_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("HOME PAGE"),
        actions: [
          IconButton(
              onPressed: () {
                AuthService().signOut();
              },
              icon: Icon(
                Icons.logout,
                color: ColorManager.White,
              ))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("ERROR");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return getChatUser(snapshot.data!.docs[index]);
            },
          );
        },
      ),
    );
  }

  Widget getChatUser(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
    if (_auth.currentUser!.uid != data["uid"]) {
      return GestureDetector(
        onTap: () {
          BlocProvider.of<ChatCubit>(context)
              .openChat(data["email"], data["uid"]);
          Navigator.pushNamed(context, Routes.chatRoute);
        },
        child: ListTile(
          leading: const Icon(
            Icons.supervised_user_circle,
          ),
          title: Text(data["email"]),
        ),
      );
    } else {
      return Container();
    }
  }
}
