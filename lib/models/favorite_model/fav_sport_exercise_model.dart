// To parse this JSON data, do
//
//     final favSportExerciseModel = favSportExerciseModelFromJson(jsonString);

import 'dart:convert';

List<FavSportExerciseModel> favSportExerciseModelFromJson(String str) =>
    List<FavSportExerciseModel>.from(
        json.decode(str).map((x) => FavSportExerciseModel.fromJson(x)));

String favSportExerciseModelToJson(List<FavSportExerciseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavSportExerciseModel {
  FavSportExerciseModel({
    this.id,
    this.uniqueKey,
    this.idExercise,
    this.idUser,
    this.sportExercise,
  });

  int? id;
  String? uniqueKey;
  int? idExercise;
  String? idUser;
  SportExercise? sportExercise;

  factory FavSportExerciseModel.fromJson(Map<String, dynamic> json) =>
      FavSportExerciseModel(
        id: json["id"],
        uniqueKey: json["unique_key"],
        idExercise: json["id_exercise"],
        idUser: json["id_user"],
        sportExercise: SportExercise.fromJson(json["sport_exercise"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unique_key": uniqueKey,
        "id_exercise": idExercise,
        "id_user": idUser,
        "sport_exercise": sportExercise,
      };
}

class SportExercise {
  SportExercise({
    this.id,
    this.name,
    this.description,
    this.linkVideo,
    this.level,
    this.thumbnail,
  });

  int? id;
  String? name;
  String? description;
  String? linkVideo;
  String? level;
  String? thumbnail;

  factory SportExercise.fromJson(Map<String, dynamic> json) => SportExercise(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        linkVideo: json["link_video"],
        level: json["level"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "link_video": linkVideo,
        "level": level,
        "thumbnail": thumbnail,
      };
}
