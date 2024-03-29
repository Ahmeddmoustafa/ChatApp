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
  late String recieverID;
  late bool calling = false;

  CallCubit() : super(CallInitial());

  Future<void> endCall() async {
    try {
      await _firestore
          .collection("call_rooms")
          .doc(recieverID)
          .set({"status": "END"}, SetOptions(merge: true));

      calling = false;
      emit(EndCall());
    } on FirebaseException catch (err) {
      print("end error ${err.message}");
      emit(CallError(msg: err.message.toString()));
    }
  }

  void acceptCall() async {
    final String currUserId = _firebaseAuth.currentUser!.uid;
    final String currUserEmail = _firebaseAuth.currentUser!.email.toString();
    try {
      final DocumentSnapshot docSnapshot =
          await _firestore.collection("call_rooms").doc(currUserId).get();
      if (docSnapshot.exists && docSnapshot['status'] == 'PENDING') {
        // int length = querySnapshot.docs.length;
        // final QueryDocumentSnapshot callData = docSnapshot[]
        recieverID = currUserId;
        callerID = docSnapshot["callerId"].toString();
        String callerEmail = docSnapshot["callerEmail"].toString();

        calling = true;
        print("the user $callerID is calling");

        // final Call call = Call(
        //   callerID: callerID!,
        //   callerEmail: callerEmail,
        //   recieverID: recieverID!,
        //   recieverEmail: currUserEmail,
        //   timestamp: Timestamp.now(),
        //   status: "ACCEPTED",
        // );

        await _firestore
            .collection("call_rooms")
            .doc(currUserId)
            .set({"status": "ACCEPTED"}, SetOptions(merge: true));
        emit(CallAccepted());
      }
    } on FirebaseException catch (err) {
      emit(CallError(msg: err.message.toString()));
    }
  }

  Stream<DocumentSnapshot> openCall() {
    final String id;
    if (calling == false) {
      id = _firebaseAuth.currentUser!.uid;
      recieverID = id;
    } else {
      id = recieverID;
    }
    // recieverID ??= _firebaseAuth.currentUser!.uid;
    print("call is recieved to $id");

    return _firestore.collection("call_rooms").doc(id).snapshots();
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
          .set(call.toMap());
      calling = true;
      print("now we should call $recieverID");
      emit(CallPending());
    } on FirebaseException catch (err) {
      emit(CallError(msg: err.message.toString()));
    }
  }
}
