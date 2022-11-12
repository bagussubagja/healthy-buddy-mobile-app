// To parse this JSON data, do
//
//     final foodReceiptModel = foodReceiptModelFromJson(jsonString);

import 'dart:convert';

List<FoodReceiptModel> foodReceiptModelFromJson(String str) => List<FoodReceiptModel>.from(json.decode(str).map((x) => FoodReceiptModel.fromJson(x)));

String foodReceiptModelToJson(List<FoodReceiptModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodReceiptModel {
    FoodReceiptModel({
        required this.id,
        required this.name,
        required this.galleryPhoto,
        required this.levelOfMaking,
        required this.rating,
        required this.ingredients,
        required this.duration,
        required this.category,
        required this.linkVideo,
        required this.description,
    });

    int id;
    String name;
    List<String> galleryPhoto;
    String levelOfMaking;
    double rating;
    List<String> ingredients;
    int duration;
    String category;
    String linkVideo;
    String description;

    factory FoodReceiptModel.fromJson(Map<String, dynamic> json) => FoodReceiptModel(
        id: json["id"],
        name: json["name"],
        galleryPhoto: List<String>.from(json["gallery_photo"].map((x) => x)),
        levelOfMaking: json["level_of_making"],
        rating: json["rating"].toDouble(),
        ingredients: List<String>.from(json["ingredients"].map((x) => x)),
        duration: json["duration"],
        category: json["category"],
        linkVideo: json["link_video"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "gallery_photo": List<dynamic>.from(galleryPhoto.map((x) => x)),
        "level_of_making": levelOfMaking,
        "rating": rating,
        "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
        "duration": duration,
        "category": category,
        "link_video": linkVideo,
        "description": description,
    };
}
