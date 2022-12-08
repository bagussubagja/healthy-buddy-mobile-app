// ignore_for_file: use_build_context_synchronously

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/models/mydoc_model/mydoc_appointment_model.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

import '../../../../core/mydoc/mydoc_notifier.dart';

class VideoCallScreen extends StatefulWidget {
  final String conferenceID;
  final String name;
  final String idDoctor;

  const VideoCallScreen({
    Key? key,
    required this.conferenceID,
    required this.name,
    required this.idDoctor,
  }) : super(key: key);

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  final String localUserID = math.Random().nextInt(10000).toString();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltCall(
        appID: 1767211691,
        appSign:
            "b5fcf905ae4ea9926ab614bc9061a714325fca98caf5127045256b8b4319fd80",
        userID: localUserID,
        userName: widget.name,
        callID: widget.conferenceID,
        config: ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
          ..onHangUp = () async {
            await doUpdate();
          }
          ..onOnlySelfInRoom = (context) async {
            await doUpdate();
          },
      ),
    );
  }

  doUpdate() async {
    final user = Provider.of<MyDocScheduleAppointmentClass>(context, listen: false);
    AppointmentScheduleModel model = AppointmentScheduleModel(
      isCompleted: true,
    );

    var update =
        Provider.of<UpdateStatusAppointmentClass>(context, listen: false);
    await update.updateStatus(
        model, '${user.schedule?[0].users?.idUser}', widget.idDoctor, context);
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: 'Selamat!',
        message:
            'Kamu telah janji-temu virtual dengan dokter, semoga harimu menyenangkan!',
        contentType: ContentType.success,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
    Navigator.pushNamedAndRemoveUntil(
        context, AppRoutes.bodyScreen, (route) => false);
  }
}
