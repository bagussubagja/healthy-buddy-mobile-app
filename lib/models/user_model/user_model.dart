// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

List<UserModel> userModelFromJson(String str) =>
    List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

String userModelToJson(List<UserModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserModel {
  UserModel({
    this.idUser,
    this.email,
    this.name,
    this.gender,
    this.hasDiscount,
    this.balance,
    this.address,
  });

  String? idUser;
  String? email;
  String? name;
  String? gender;
  bool? hasDiscount;
  int? balance;
  String? address;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        idUser: json["id_user"],
        email: json["email"],
        name: json["name"],
        gender: json["gender"],
        hasDiscount: json["hasDiscount"],
        balance: json["balance"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "email": email,
        "name": name,
        "gender": gender,
        "address": address,
      };

      Map<String, dynamic> updateName() => {
        "name": name,
      };

      Map<String, dynamic> updateAddress() => {
        "address": address,
      };

      Map<String, dynamic> updateEmail() => {
        "email": email,
      };
}
