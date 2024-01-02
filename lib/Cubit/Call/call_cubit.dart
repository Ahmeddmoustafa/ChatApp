import 'package:bloc/bloc.dart';
import 'package:chat_app/Models/call.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
part 'call_state.dart';

class CallCubit extends Cubit<CallState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? callerID;
  String? recieverID;
  bool calling = false;

  CallCubit() : super(CallInitial());

  Future<void> endCall() async {
    try {
      await _firestore.collection("call_rooms").doc(recieverID).delete();
      calling = false;
      emit(EndCall());
    } on FirebaseException catch (err) {
      emit(CallError(msg: err.message.toString()));
    }
  }

  void acceptCall() async {
    final String currUserId = _firebaseAuth.currentUser!.uid;
    final String currUserEmail = _firebaseAuth.currentUser!.email.toString();
    try {
      final QuerySnapshot querySnapshot = await _firestore
          .collection("call_rooms")
          .doc(currUserId)
          .collection("call")
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        int length = querySnapshot.docs.length;
        final QueryDocumentSnapshot callData = querySnapshot.docs[length - 1];
        recieverID = currUserId;
        callerID = callData["callerId"].toString();
        String callerEmail = callData["callerEmail"].toString();

        calling = true;
        print("the user $callerID is calling");

        final Call call = Call(
          callerID: callerID!,
          callerEmail: callerEmail,
          recieverID: recieverID!,
          recieverEmail: currUserEmail,
          timestamp: Timestamp.now(),
          status: "ACCEPTED",
        );

        await _firestore
            .collection("call_rooms")
            .doc(currUserId)
            .collection("call")
            .add(call.toMap());
        emit(CallAccepted());
      }
    } on FirebaseException catch (err) {
      emit(CallError(msg: err.message.toString()));
    }
  }

  Stream<QuerySnapshot> openCall() {
    print("call is recieved to $recieverID");
    if (recieverID!.isNotEmpty) {
      emit(CallPending());
    }
    final Stream<QuerySnapshot> querySnapshot = _firestore
        .collection("call_rooms")
        .doc(recieverID)
        .collection("call")
        .orderBy("timeStamp", descending: true)
        .snapshots();
    return querySnapshot;
  }

  Future<void> callUser(String recieverUid, String recieverEmail) async {
    emit(CallInitial());
    final String currUserId = _firebaseAuth.currentUser!.uid;
    final String currUserEmail = _firebaseAuth.currentUser!.email.toString();
    callerID = currUserId;
    recieverID = recieverUid;

    final Call call = Call(
      callerID: currUserId,
      callerEmail: currUserEmail,
      recieverID: recieverUid,
      recieverEmail: recieverEmail,
      timestamp: Timestamp.now(),
      status: "PENDING",
    );

    try {
      // final String chatRoomId = getRoomId(currUserId, recieverUid);
      await _firestore
          .collection("call_rooms")
          .doc(call.recieverID)
          .collection("call")
          .add(
            call.toMap(),
          );
      calling = true;
      emit(CallPending());
    } on FirebaseException catch (err) {
      // print("Errorr!!! ${err.message}");
      emit(CallError(msg: err.message.toString()));
    }
  }
}
