// To parse this JSON data, do
//
//     final sportStoreModel = sportStoreModelFromJson(jsonString);

import 'dart:convert';

List<SportStoreModel> sportStoreModelFromJson(String str) => List<SportStoreModel>.from(json.decode(str).map((x) => SportStoreModel.fromJson(x)));

String sportStoreModelToJson(List<SportStoreModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SportStoreModel {
    SportStoreModel({
        required this.id,
        required this.productName,
        required this.description,
        required this.gallery,
        required this.price,
        required this.review,
        required this.reviewerName,
        required this.merk,
        required this.category,
    });

    int id;
    String productName;
    String description;
    List<String> gallery;
    int price;
    List<String> review;
    List<String> reviewerName;
    String merk;
    String category;

    factory SportStoreModel.fromJson(Map<String, dynamic> json) => SportStoreModel(
        id: json["id"],
        productName: json["product_name"],
        description: json["description"],
        gallery: List<String>.from(json["gallery"].map((x) => x)),
        price: json["price"],
        review: List<String>.from(json["review"].map((x) => x)),
        reviewerName: List<String>.from(json["reviewer_name"].map((x) => x)),
        merk: json["merk"],
        category: json["category"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "product_name": productName,
        "description": description,
        "gallery": List<dynamic>.from(gallery.map((x) => x)),
        "price": price,
        "review": List<dynamic>.from(review.map((x) => x)),
        "reviewer_name": List<dynamic>.from(reviewerName.map((x) => x)),
        "merk": merk,
        "category": category,
    };
}
