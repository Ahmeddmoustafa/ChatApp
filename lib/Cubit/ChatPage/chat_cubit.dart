import 'package:bloc/bloc.dart';
import 'package:chat_app/Models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  late String recieverEmail;
  late String recieverUid;
  late String chatRoomId;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  ChatCubit() : super(ChatInitial());

  String getRoomId(String uid, String recieverID) {
    List<String> ids = [uid, recieverUid];
    ids.sort();
    chatRoomId = ids.join("_");
    return chatRoomId;
  }

  void openChat(String email, String id) {
    emit(ChatInitial());
    recieverEmail = email;
    recieverUid = id;
    emit(ChatOpened());
  }

  void sendMessage(String msg) async {
    final String currUserId = _firebaseAuth.currentUser!.uid;
    final String currUserEmail = _firebaseAuth.currentUser!.email.toString();
    final Timestamp timestamp = Timestamp.now();
    // create new message
    final Message message = Message(
      message: msg,
      senderID: currUserId,
      senderEmail: currUserEmail,
      recieverID: recieverUid,
      recieverEmail: recieverEmail,
      timestamp: timestamp,
    );

    // List<String> ids = [currUserId, recieverUid];
    // ids.sort();
    final String chatRoomId = getRoomId(currUserId, recieverUid);
    await _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .add(
          message.toMap(),
        );
  }

  Stream<QuerySnapshot> getMessages(String uId, String recieverId) {
    // List<String> ids = [uId, recieverUid];
    // ids.sort();
    final String chatRoomId = getRoomId(uId, recieverUid);

    return _firestore
        .collection("chat_rooms")
        .doc(chatRoomId)
        .collection("messages")
        .orderBy("timeStamp", descending: false)
        .snapshots();
  }
}
