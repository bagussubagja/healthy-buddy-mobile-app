// To parse this JSON data, do
//
//     final favMyDocModel = favMyDocModelFromJson(jsonString);

import 'dart:convert';

List<FavMyDocModel> favMyDocModelFromJson(String str) =>
    List<FavMyDocModel>.from(
        json.decode(str).map((x) => FavMyDocModel.fromJson(x)));

String favMyDocModelToJson(List<FavMyDocModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavMyDocModel {
  FavMyDocModel({
    this.id,
    this.uniqueKey,
    this.idDoc,
    this.idUser,
    this.myDoc,
  });

  int? id;
  String? uniqueKey;
  int? idDoc;
  String? idUser;
  MyDoc? myDoc;

  factory FavMyDocModel.fromJson(Map<String, dynamic> json) => FavMyDocModel(
        id: json["id"],
        uniqueKey: json["unique_key"],
        idDoc: json["id_doc"],
        idUser: json["id_user"],
        myDoc: MyDoc.fromJson(json["my_doc"]),
      );

  Map<String, dynamic> toJson() => {
        "unique_key": uniqueKey,
        "id_doc": idDoc,
        "id_user": idUser,
      };
}

class MyDoc {
  MyDoc({
    this.id,
    this.name,
    this.specialist,
    this.description,
    this.patients,
    this.yearExp,
    this.rating,
    this.operationalHour,
    this.hospital,
    this.thumbnail,
    this.price,
    this.isExperience,
  });

  int? id;
  String? name;
  String? specialist;
  String? description;
  int? patients;
  int? yearExp;
  int? rating;
  String? operationalHour;
  String? hospital;
  String? thumbnail;
  int? price;
  bool? isExperience;

  factory MyDoc.fromJson(Map<String, dynamic> json) => MyDoc(
        id: json["id"],
        name: json["name"],
        specialist: json["specialist"],
        description: json["description"],
        patients: json["patients"],
        yearExp: json["year exp"],
        rating: json["rating"],
        operationalHour: json["operational_hour"],
        hospital: json["hospital"],
        thumbnail: json["thumbnail"],
        price: json["price"],
        isExperience: json["isExperience"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "specialist": specialist,
        "description": description,
        "patients": patients,
        "year exp": yearExp,
        "rating": rating,
        "operational_hour": operationalHour,
        "hospital": hospital,
        "thumbnail": thumbnail,
        "price": price,
        "isExperience": isExperience,
      };
}
