// To parse this JSON data, do
//
//     final sportWebsiteModel = sportWebsiteModelFromJson(jsonString);

import 'dart:convert';

List<SportWebsiteModel> sportWebsiteModelFromJson(String str) =>
    List<SportWebsiteModel>.from(
        json.decode(str).map((x) => SportWebsiteModel.fromJson(x)));

String sportWebsiteModelToJson(List<SportWebsiteModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SportWebsiteModel {
  SportWebsiteModel({
    required this.id,
    required this.title,
    required this.link,
    required this.category,
  });

  int id;
  String title;
  String link;
  String category;

  factory SportWebsiteModel.fromJson(Map<String, dynamic> json) =>
      SportWebsiteModel(
        id: json["id"],
        title: json["title"],
        link: json["link"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "link": link,
        "category": category,
      };
}
