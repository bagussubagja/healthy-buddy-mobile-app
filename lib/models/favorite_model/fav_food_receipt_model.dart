// To parse this JSON data, do
//
//     final favFoodReceiptModel = favFoodReceiptModelFromJson(jsonString);

import 'dart:convert';

List<FavFoodReceiptModel> favFoodReceiptModelFromJson(String str) =>
    List<FavFoodReceiptModel>.from(
        json.decode(str).map((x) => FavFoodReceiptModel.fromJson(x)));

String favFoodReceiptModelToJson(List<FavFoodReceiptModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavFoodReceiptModel {
  FavFoodReceiptModel({
    this.id,
    this.uniqueKey,
    this.idReceipt,
    this.idUser,
    this.foodReceipt,
  });

  int? id;
  String? uniqueKey;
  int? idReceipt;
  String? idUser;
  FoodReceipt? foodReceipt;

  factory FavFoodReceiptModel.fromJson(Map<String, dynamic> json) =>
      FavFoodReceiptModel(
        id: json["id"],
        uniqueKey: json["unique_key"],
        idReceipt: json["id_receipt"],
        idUser: json["id_user"],
        foodReceipt: FoodReceipt.fromJson(json["food_receipt"]),
      );

  Map<String, dynamic> toJson() => {
        "unique_key": uniqueKey,
        "id_receipt": idReceipt,
        "id_user": idUser,
      };
}

class FoodReceipt {
  FoodReceipt({
    this.id,
    this.name,
    this.galleryPhoto,
    this.levelOfMaking,
    this.rating,
    this.ingredients,
    this.duration,
    this.category,
    this.linkVideo,
    this.description,
  });

  int? id;
  String? name;
  List<String>? galleryPhoto;
  String? levelOfMaking;
  int? rating;
  List<String>? ingredients;
  int? duration;
  String? category;
  String? linkVideo;
  String? description;

  factory FoodReceipt.fromJson(Map<String, dynamic> json) => FoodReceipt(
        id: json["id"],
        name: json["name"],
        galleryPhoto: List<String>.from(json["gallery_photo"].map((x) => x)),
        levelOfMaking: json["level_of_making"],
        rating: json["rating"],
        ingredients: List<String>.from(json["ingredients"].map((x) => x)),
        duration: json["duration"],
        category: json["category"],
        linkVideo: json["link_video"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "gallery_photo": galleryPhoto,
        "level_of_making": levelOfMaking,
        "rating": rating,
        "ingredients": ingredients,
        "duration": duration,
        "category": category,
        "link_video": linkVideo,
        "description": description,
      };
}
