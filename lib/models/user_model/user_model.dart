// // To parse this JSON data, do
// //
// //     final userModel = userModelFromJson(jsonString);

// import 'dart:convert';
// import 'dart:ffi';

// List<UserModel> userModelFromJson(String str) =>
//     List<UserModel>.from(json.decode(str).map((x) => UserModel.fromJson(x)));

// String userModelToJson(List<UserModel> data) =>
//     json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class UserModel {
//   UserModel({
//     this.idUser,
//     this.email,
//     this.name,
//     this.gender,
//     this.hasDiscount,
//     this.balance,
//     this.address,
//   });

//   String? idUser;
//   String? email;
//   String? name;
//   String? gender;
//   bool? hasDiscount;
//   int? balance;
//   String? address;

//   factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
//         idUser: json["id_user"],
//         email: json["email"],
//         name: json["name"],
//         gender: json["gender"],
//         hasDiscount: json["hasDiscount"],
//         balance: json["balance"] as int,
//         address: json["address"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id_user": idUser,
//         "email": email,
//         "name": name,
//         "gender": gender,
//         "address": address,
//       };

//   Map<String, dynamic> updateName() => {
//         "name": name,
//       };

//   Map<String, dynamic> updateAddress() => {
//         "address": address,
//       };

//   Map<String, dynamic> updateBalanceData() => {
//         "balance": balance,
//       };

//   Map<String, dynamic> updateDiscountStatus() => {
//         "hasDiscount": hasDiscount,
//       };
// }

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
    this.id,
    this.idUser,
    this.email,
    this.name,
    this.gender,
    this.hasDiscount,
    this.balance,
    this.address,
    this.age,
    this.weight,
    this.height,
    this.dailyActivity,
    this.dailyCalories,
  });

  int? id;
  String? idUser;
  String? email;
  String? name;
  String? gender;
  bool? hasDiscount;
  int? balance;
  String? address;
  int? age;
  int? weight;
  int? height;
  String? dailyActivity;
  double? dailyCalories;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        idUser: json["id_user"],
        email: json["email"],
        name: json["name"],
        gender: json["gender"],
        hasDiscount: json["hasDiscount"],
        balance: json["balance"],
        address: json["address"],
        age: json["age"],
        weight: json["weight"],
        height: json["height"],
        dailyActivity: json["daily_activity"],
        dailyCalories: json["daily_calories"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "email": email,
        "name": name,
        "gender": gender,
        "address": address,
        "age": age,
        "weight": weight,
        "height": height,
        "daily_activity": dailyActivity,
        "daily_calories": dailyCalories,
      };

  Map<String, dynamic> updateName() => {
        "name": name,
      };

  Map<String, dynamic> updateAddress() => {
        "address": address,
      };

  Map<String, dynamic> updateBalanceData() => {
        "balance": balance,
      };

  Map<String, dynamic> updateDiscountStatus() => {
        "hasDiscount": hasDiscount,
      };

  Map<String, dynamic> selfData() => {
        "age": age,
        "weight": weight,
        "height": height,
        "dailyActivity": dailyActivity,
        "dailyCalories": dailyCalories
      };
}
