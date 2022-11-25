// To parse this JSON data, do
//
//     final sportStoreModel = sportStoreModelFromJson(jsonString);

import 'dart:convert';

List<SportStoreModel> sportStoreModelFromJson(String str) => List<SportStoreModel>.from(json.decode(str).map((x) => SportStoreModel.fromJson(x)));

String sportStoreModelToJson(List<SportStoreModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SportStoreModel {
    SportStoreModel({
        this.id,
        this.productName,
        this.description,
        this.gallery,
        this.price,
        this.review,
        this.reviewerName,
        this.merk,
        this.category,
    });

    int? id;
    String? productName;
    String? description;
    List<String>? gallery;
    int? price;
    List<String>? review;
    List<String>? reviewerName;
    String? merk;
    String? category;

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
        "gallery": gallery,
        "price": price,
        "review": review,
        "reviewer_name": reviewerName,
        "merk": merk,
        "category": category,
    };
}
