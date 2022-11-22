// To parse this JSON data, do
//
//     final sportArticleModel = sportArticleModelFromJson(jsonString);

import 'dart:convert';

List<SportArticleModel> sportArticleModelFromJson(String str) => List<SportArticleModel>.from(json.decode(str).map((x) => SportArticleModel.fromJson(x)));

String sportArticleModelToJson(List<SportArticleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SportArticleModel {
    SportArticleModel({
        required this.id,
        required this.title,
        required this.description,
        required this.link,
        required this.thumbnail,
    });

    int id;
    String title;
    String description;
    String link;
    String thumbnail;

    factory SportArticleModel.fromJson(Map<String, dynamic> json) => SportArticleModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        link: json["link"],
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "link": link,
        "thumbnail": thumbnail,
    };
}
