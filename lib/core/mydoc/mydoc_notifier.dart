import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/models/mydoc_model/mydoc_model.dart';
import 'package:healthy_buddy_mobile_app/services/my_doc_service/my_doc_exp_service.dart';
import 'package:healthy_buddy_mobile_app/services/my_doc_service/my_doc_service.dart';

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
