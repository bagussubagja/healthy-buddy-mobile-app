// To parse this JSON data, do
//
//     final wishlistSportModel = wishlistSportModelFromJson(jsonString);

import 'dart:convert';

List<WishlistSportModel> wishlistSportModelFromJson(String str) =>
    List<WishlistSportModel>.from(
        json.decode(str).map((x) => WishlistSportModel.fromJson(x)));

String wishlistSportModelToJson(List<WishlistSportModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WishlistSportModel {
  WishlistSportModel({
    this.id,
    this.idUser,
    this.idSportStoreItem,
    this.itemUniqueKey,
    this.sportStore,
  });

  int? id;
  String? idUser;
  int? idSportStoreItem;
  String? itemUniqueKey;
  SportStore? sportStore;

  factory WishlistSportModel.fromJson(Map<String, dynamic> json) =>
      WishlistSportModel(
        id: json["id"],
        idUser: json["id_user"],
        idSportStoreItem: json["id_sport_store_item"],
        itemUniqueKey: json["item_unique_key"],
        sportStore: SportStore.fromJson(json["sport_store"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "id_sport_store_item": idSportStoreItem,
        "item_unique_key": itemUniqueKey,
        "sport_store": sportStore?.toJson(),
      };
}

class SportStore {
  SportStore({
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

  factory SportStore.fromJson(Map<String, dynamic> json) => SportStore(
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
