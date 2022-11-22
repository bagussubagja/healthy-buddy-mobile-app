import 'package:flutter/material.dart';
import 'package:healthy_buddy_mobile_app/models/sport_model/sport_exercise_model.dart';
import 'package:healthy_buddy_mobile_app/services/sport_services/sport_exercise_all_service.dart';
import 'package:healthy_buddy_mobile_app/services/sport_services/sport_exercise_bylevel_service.dart';

class SportExerciseAllClass extends ChangeNotifier {
  List<SportExerciseModel>? sportExercise;
  getSport({required BuildContext context}) async {
    sportExercise =
        (await getSportExerciseAllCategory(context: context));
    notifyListeners();
  }
}

class SportExerciseEasyClass extends ChangeNotifier {
  List<SportExerciseModel>? sportExercise;
  getSport({required BuildContext context, required String category}) async {
    sportExercise =
        (await getSportExerciseByLevel(context: context, level: 'Easy'));
    notifyListeners();
  }
}

class SportExerciseMediumClass extends ChangeNotifier {
  List<SportExerciseModel>? sportExercise;
  getSport({required BuildContext context, required String category}) async {
    sportExercise =
        (await getSportExerciseByLevel(context: context, level: 'Medium'));
    notifyListeners();
  }
}

class SportExerciseHardClass extends ChangeNotifier {
  List<SportExerciseModel>? sportExercise;
  getSport({required BuildContext context, required String category}) async {
    sportExercise =
        (await getSportExerciseByLevel(context: context, level: 'Hard'));
    notifyListeners();
  }
}
