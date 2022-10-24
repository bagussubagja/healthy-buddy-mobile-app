// To parse this JSON data, do
//
//     final foodArticleCarouselModel = foodArticleCarouselModelFromJson(jsonString);

import 'dart:convert';

List<FoodArticleCarouselModel> foodArticleCarouselModelFromJson(String str) => List<FoodArticleCarouselModel>.from(json.decode(str).map((x) => FoodArticleCarouselModel.fromJson(x)));

String foodArticleCarouselModelToJson(List<FoodArticleCarouselModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodArticleCarouselModel {
    FoodArticleCarouselModel({
        this.id,
        this.title,
        this.description,
        this.link,
        this.thumbnail,
    });

    int? id;
    List<String>? title;
    List<String>? description;
    List<String>? link;
    List<String>? thumbnail;

    factory FoodArticleCarouselModel.fromJson(Map<String, dynamic> json) => FoodArticleCarouselModel(
        id: json["id"],
        title: List<String>.from(json["title"].map((x) => x)),
        description: List<String>.from(json["description"].map((x) => x)),
        link: List<String>.from(json["link"].map((x) => x)),
        thumbnail: List<String>.from(json["thumbnail"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": List<dynamic>.from(title!.map((x) => x)),
        "description": List<dynamic>.from(description!.map((x) => x)),
        "link": List<dynamic>.from(link!.map((x) => x)),
        "thumbnail": List<dynamic>.from(thumbnail!.map((x) => x)),
    };
}
