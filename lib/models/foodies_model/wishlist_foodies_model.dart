// To parse this JSON data, do
//
//     final wishlistFoodiesModel = wishlistFoodiesModelFromJson(jsonString);

import 'dart:convert';

List<WishlistFoodiesModel> wishlistFoodiesModelFromJson(String str) => List<WishlistFoodiesModel>.from(json.decode(str).map((x) => WishlistFoodiesModel.fromJson(x)));

String wishlistFoodiesModelToJson(List<WishlistFoodiesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WishlistFoodiesModel {
    WishlistFoodiesModel({
        this.id,
        this.idUser,
        this.idFoodiesStoreItem,
        this.itemUniqueKey,
        this.foodStore,
    });

    int? id;
    String? idUser;
    int? idFoodiesStoreItem;
    String? itemUniqueKey;
    FoodStore? foodStore;

    factory WishlistFoodiesModel.fromJson(Map<String, dynamic> json) => WishlistFoodiesModel(
        id: json["id"],
        idUser: json["id_user"],
        idFoodiesStoreItem: json["id_foodies_store_item"],
        itemUniqueKey: json["item_unique_key"],
        foodStore: FoodStore.fromJson(json["food_store"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "id_user": idUser,
        "id_foodies_store_item": idFoodiesStoreItem,
        "item_unique_key": itemUniqueKey,
        "food_store": foodStore?.toJson(),
    };
}

class FoodStore {
    FoodStore({
        this.id,
        this.name,
        this.description,
        this.gallery,
        this.price,
        this.category,
    });

    int? id;
    String? name;
    String? description;
    List<String>? gallery;
    int? price;
    String? category;

    factory FoodStore.fromJson(Map<String, dynamic> json) => FoodStore(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        gallery: List<String>.from(json["gallery"].map((x) => x)),
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
