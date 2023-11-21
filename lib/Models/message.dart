import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String message;
  final String senderID;
  final String senderEmail;
  final String recieverID;
  final String recieverEmail;
  final Timestamp timestamp;

  Message({
    required this.message,
    required this.senderID,
    required this.senderEmail,
    required this.recieverID,
    required this.recieverEmail,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      "senderId": senderID,
      "senderEmail": senderEmail,
      "message": message,
      "recieverId": recieverID,
      "recieverEmail": recieverEmail,
      "timeStamp": timestamp,
    };
  }
}
