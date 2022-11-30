import 'package:flutter/material.dart';
import 'package:zego_uikit_prebuilt_video_conference/zego_uikit_prebuilt_video_conference.dart';
import 'dart:math' as math;

class VideoCallScreen extends StatefulWidget {
  final String conferenceID;
  final String name;

  const VideoCallScreen({
    Key? key,
    required this.conferenceID, required this.name,
  }) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final String localUserID = math.Random().nextInt(10000).toString();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltVideoConference(
        appID: 1767211691,
        appSign:
            "b5fcf905ae4ea9926ab614bc9061a714325fca98caf5127045256b8b4319fd80",
        userID: localUserID,
        userName: widget.name,
        conferenceID: widget.conferenceID,
        config: ZegoUIKitPrebuiltVideoConferenceConfig(),
      ),
    );
  }
}