// To parse this JSON data, do
//
//     final sportExerciseModel = sportExerciseModelFromJson(jsonString);

import 'dart:convert';

List<SportExerciseModel> sportExerciseModelFromJson(String str) =>
    List<SportExerciseModel>.from(
        json.decode(str).map((x) => SportExerciseModel.fromJson(x)));

String sportExerciseModelToJson(List<SportExerciseModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SportExerciseModel {
  SportExerciseModel({
    required this.id,
    required this.name,
    required this.description,
    required this.linkVideo,
    required this.level,
    required this.thumbnail,
  });

  int id;
  String name;
  String description;
  String linkVideo;
  String level;
  String thumbnail;

  factory SportExerciseModel.fromJson(Map<String, dynamic> json) =>
      SportExerciseModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        linkVideo: json["link_video"],
        level: json["level"],
        thumbnail: json["thumbnail"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "link_video": linkVideo,
        "level": level,
        "thumbnail": thumbnail,
      };
}
