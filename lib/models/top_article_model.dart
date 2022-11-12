// To parse this JSON data, do
//
//     final topArticleModel = topArticleModelFromJson(jsonString);

import 'dart:convert';

List<TopArticleModel> topArticleModelFromJson(String str) => List<TopArticleModel>.from(json.decode(str).map((x) => TopArticleModel.fromJson(x)));

String topArticleModelToJson(List<TopArticleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TopArticleModel {
    TopArticleModel({
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

    factory TopArticleModel.fromJson(Map<String, dynamic> json) => TopArticleModel(
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
