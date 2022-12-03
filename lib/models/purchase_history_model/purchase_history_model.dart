// To parse this JSON data, do
//
//     final purchaseHistoryModel = purchaseHistoryModelFromJson(jsonString);

import 'dart:convert';

List<PurchaseHistoryModel> purchaseHistoryModelFromJson(String str) =>
    List<PurchaseHistoryModel>.from(
        json.decode(str).map((x) => PurchaseHistoryModel.fromJson(x)));

String purchaseHistoryModelToJson(List<PurchaseHistoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PurchaseHistoryModel {
  PurchaseHistoryModel({
    this.id,
    this.productName,
    this.thumbnail,
    this.price,
    this.createdAt,
    this.category,
    this.quantity,
    this.idUser,
  });

  int? id;
  String? productName;
  String? thumbnail;
  int? price;
  String? createdAt;
  String? category;
  int? quantity;
  String? idUser;

  factory PurchaseHistoryModel.fromJson(Map<String, dynamic> json) =>
      PurchaseHistoryModel(
        id: json["id"],
        productName: json["productName"],
        thumbnail: json["thumbnail"],
        price: json["price"],
        createdAt: json["created_at"],
        category: json["category"],
        quantity: json["quantity"],
        idUser: json["id_user"],
      );

  Map<String, dynamic> toJson() => {
        "productName": productName,
        "thumbnail": thumbnail,
        "price": price,
        "created_at": createdAt,
        "category": category,
        "quantity": quantity,
        "id_user": idUser,
      };
}
