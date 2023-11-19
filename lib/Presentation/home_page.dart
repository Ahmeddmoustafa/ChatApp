import 'package:chat_app/Presentation/auth/auth_services.dart';
import 'package:chat_app/Resources/Managers/colors_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              icon: const Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("ERROR");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("WAITING");
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
    return ListTile(
      title: Text(data["email"]),
    );
  }
}
