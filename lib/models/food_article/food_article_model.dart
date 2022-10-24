// To parse this JSON data, do
//
//     final foodArticleModel = foodArticleModelFromJson(jsonString);

import 'dart:convert';

List<FoodArticleModel> foodArticleModelFromJson(String str) => List<FoodArticleModel>.from(json.decode(str).map((x) => FoodArticleModel.fromJson(x)));

String foodArticleModelToJson(List<FoodArticleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodArticleModel {
    FoodArticleModel({
        this.id,
        this.title,
        this.description,
        this.link,
        this.thumbnail,
    });

    int? id;
    String? title;
    String? description;
    String? link;
    String? thumbnail;

    factory FoodArticleModel.fromJson(Map<String, dynamic> json) => FoodArticleModel(
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
