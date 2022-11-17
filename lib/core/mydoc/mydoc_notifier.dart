import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/models/mydoc_model/mydoc_model.dart';
import 'package:healthy_buddy_mobile_app/services/my_doc_service/my_doc_exp_service.dart';
import 'package:healthy_buddy_mobile_app/services/my_doc_service/my_doc_service.dart';

class MyDocByPulmonologyClass extends ChangeNotifier {
  List<MyDocModel>? mydocModel;
  getDoctor({required BuildContext context, required String specialist}) async {
    mydocModel =
        (await getDoctorBySpecialist(context: context, specialist: 'Pulmonology'));
    notifyListeners();
  }
}

class MyDocByCardiologyClass extends ChangeNotifier {
  List<MyDocModel>? mydocModel;
  getDoctor({required BuildContext context, required String specialist}) async {
    mydocModel =
        (await getDoctorBySpecialist(context: context, specialist: 'Cardiology'));
    notifyListeners();
  }
}

class MyDocByMentalHealthClass extends ChangeNotifier {
  List<MyDocModel>? mydocModel;
  getDoctor({required BuildContext context, required String specialist}) async {
    mydocModel =
        (await getDoctorBySpecialist(context: context, specialist: 'Mental Health'));
    notifyListeners();
  }
}

class MyDocByHepatologyClass extends ChangeNotifier {
  List<MyDocModel>? mydocModel;
  getDoctor({required BuildContext context, required String specialist}) async {
    mydocModel =
        (await getDoctorBySpecialist(context: context, specialist: 'Hepatology'));
    notifyListeners();
  }
}

class MyDocByExperienceClass extends ChangeNotifier {
  List<MyDocModel>? mydocModel;
  getDoctor({required BuildContext context, required String isExperience}) async {
    mydocModel =
        (await getDoctorByExperience(context: context, isExperience: 'true'));
    notifyListeners();
  }
}