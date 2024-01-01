import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';

class CallPage extends StatefulWidget {
  const CallPage({super.key});

  @override
  State<CallPage> createState() => _CallPageState();
}

class _CallPageState extends State<CallPage> {
  final AgoraClient client = AgoraClient(
    agoraConnectionData: AgoraConnectionData(
        appId: "c43ec6834d624b10b180971d855eb49c", channelName: "test"),
    enabledPermission: [Permission.camera, Permission.microphone],
  );

  @override
  void initState() {
    super.initState();
    initClient();
  }

  void initClient() async {
    await client.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AgoraVideoViewer(client: client),
    );
  }
}
