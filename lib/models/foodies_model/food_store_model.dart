// To parse this JSON data, do
//
//     final foodStoreModel = foodStoreModelFromJson(jsonString);

import 'dart:convert';

List<FoodStoreModel> foodStoreModelFromJson(String str) =>
    List<FoodStoreModel>.from(
        json.decode(str).map((x) => FoodStoreModel.fromJson(x)));

String foodStoreModelToJson(List<FoodStoreModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodStoreModel {
  FoodStoreModel({
    required this.id,
    required this.name,
    required this.description,
    required this.gallery,
    required this.price,
    required this.category,
  });

  int id;
  String name;
  String description;
  dynamic gallery;
  int price;
  String category;

  factory FoodStoreModel.fromJson(Map<String, dynamic> json) => FoodStoreModel(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        gallery: json["gallery"],
        price: json["price"],
        category: json["category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "gallery": gallery,
        "price": price,
        "category": category,
      };
}
