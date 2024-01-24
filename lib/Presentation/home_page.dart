import 'package:chat_app/Cubit/ChatPage/chat_cubit.dart';
import 'package:chat_app/Presentation/auth/auth_services.dart';
import 'package:chat_app/Resources/Managers/colors_manager.dart';
import 'package:chat_app/Resources/Managers/routes_manager.dart';
import 'package:chat_app/Resources/Managers/values_manager.dart';
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
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorManager.Black,
        extendBody: false,
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   title: const Text("HOME PAGE"),
        //   actions: [
        //     IconButton(
        //         onPressed: () {
        //           AuthService().signOut();
        //         },
        //         icon: Icon(
        //           Icons.logout,
        //           color: ColorManager.White,
        //         ))
        //   ],
        // ),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: height * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          Icons.logout,
                          color: ColorManager.White,
                        ),
                        Text(
                          "HOME PAGE",
                          style: TextStyle(color: ColorManager.White),
                        ),
                        Icon(
                          Icons.supervised_user_circle,
                          color: ColorManager.LightGrey,
                          size: 40,
                        ),
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(horizontal: AppSize.s20),
                        height: height * 0.15,
                        width: width,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 10,
                            itemBuilder: (context, index) {
                              return Container(
                                margin:
                                    const EdgeInsets.only(right: AppSize.s10),
                                width: width * 0.2,
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.account_circle,
                                      color: ColorManager.White,
                                      size: 50,
                                    ),
                                    Text(
                                      "Name",
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          TextStyle(color: ColorManager.White),
                                    )
                                  ],
                                ),
                              );
                            })),
                  ],
                ),
              ),
              Container(
                width: width,
                height: height * 0.75,
                decoration: BoxDecoration(
                    color: ColorManager.White,
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(30))),
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text("ERROR");
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      // physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return getChatUser(snapshot.data!.docs[index]);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
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
            size: 40,
          ),
          title: Text(data["email"]),
        ),
      );
    } else {
      return Container();
    }
  }
}
