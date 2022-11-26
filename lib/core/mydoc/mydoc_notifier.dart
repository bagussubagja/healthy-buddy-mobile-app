import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/routes/routes.dart';
import 'package:http/http.dart' as http;
import 'package:healthy_buddy_mobile_app/models/mydoc_model/mydoc_appointment_model.dart';
import 'package:healthy_buddy_mobile_app/models/mydoc_model/mydoc_model.dart';
import 'package:healthy_buddy_mobile_app/services/my_doc_service/my_doc_appoinment_service.dart';
import 'package:healthy_buddy_mobile_app/services/my_doc_service/my_doc_exp_service.dart';
import 'package:healthy_buddy_mobile_app/services/my_doc_service/my_doc_service.dart';

import '../../shared/theme.dart';

class MyDocByPulmonologyClass extends ChangeNotifier {
  List<MyDocModel>? mydocModel;
  bool isLoading = false;
  getDoctor({required BuildContext context, required String specialist}) async {
    isLoading = true;
    mydocModel = (await getDoctorBySpecialist(
        context: context, specialist: 'Pulmonology'));
    isLoading = false;
    notifyListeners();
  }
}

class MyDocByCardiologyClass extends ChangeNotifier {
  List<MyDocModel>? mydocModel;
  bool isLoading = false;
  getDoctor({required BuildContext context, required String specialist}) async {
    isLoading = true;
    mydocModel = (await getDoctorBySpecialist(
        context: context, specialist: 'Cardiology'));
    isLoading = false;
    notifyListeners();
  }
}

class MyDocByMentalHealthClass extends ChangeNotifier {
  List<MyDocModel>? mydocModel;
  bool isLoading = false;
  getDoctor({required BuildContext context, required String specialist}) async {
    isLoading = true;
    mydocModel = (await getDoctorBySpecialist(
        context: context, specialist: 'Mental Health'));
    isLoading = false;
    notifyListeners();
  }
}

class MyDocByHepatologyClass extends ChangeNotifier {
  List<MyDocModel>? mydocModel;
  bool isLoading = false;
  getDoctor({required BuildContext context, required String specialist}) async {
    isLoading = true;
    mydocModel = (await getDoctorBySpecialist(
        context: context, specialist: 'Hepatology'));
    isLoading = false;
    notifyListeners();
  }
}

class MyDocByExperienceClass extends ChangeNotifier {
  List<MyDocModel>? mydocModel;
  bool isloading = false;
  getDoctor(
      {required BuildContext context, required String isExperience}) async {
    isloading = true;
    mydocModel =
        (await getDoctorByExperience(context: context, isExperience: 'true'));
    isloading = false;
    notifyListeners();
  }
}

class MyDocScheduleAppointmentClass extends ChangeNotifier {
  List<AppointmentScheduleModel>? schedule;
  bool isloading = false;
  getSchedule({required BuildContext context, required String idUser}) async {
    isloading = true;
    schedule = (await getAppointmentScheduleByUserID(
        context: context, idUser: idUser));
    isloading = false;
    notifyListeners();
  }

  Future<void> addData(
      AppointmentScheduleModel body, BuildContext context) async {
    notifyListeners();
    http.Response response = (await addAppointmentScheduleData(body, context))!;
    if (response.statusCode == 201) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        headerAnimationLoop: true,
        animType: AnimType.bottomSlide,
        title: 'Berhasil!',
        desc: 'Kamu berhasil mengadakan temu-janji dengan dokter pilihan kami!',
        buttonsTextStyle: regularStyle,
        showCloseIcon: false,
        btnOkText: "Kembali ke Menu Utama",
        btnOkOnPress: () {
          Navigator.pushNamedAndRemoveUntil(
              context, AppRoutes.bodyScreen, (route) => false);
        },
      ).show();
    }

    notifyListeners();
  }
}
