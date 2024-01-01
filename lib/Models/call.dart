import 'package:cloud_firestore/cloud_firestore.dart';

class Call {
  final String callerID;
  final String callerEmail;
  final String recieverID;
  final String recieverEmail;
  final Timestamp timestamp;
  final String status;

  Call({
    required this.callerID,
    required this.callerEmail,
    required this.recieverID,
    required this.recieverEmail,
    required this.timestamp,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      "callerId": callerID,
      "callerEmail": callerEmail,
      "recieverId": recieverID,
      "recieverEmail": recieverEmail,
      "timeStamp": timestamp,
      "status": status
    };
  }
}
