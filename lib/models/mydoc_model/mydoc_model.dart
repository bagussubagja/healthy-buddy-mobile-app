// To parse this JSON data, do
//
//     final myDocModel = myDocModelFromJson(jsonString);

import 'dart:convert';

List<MyDocModel> myDocModelFromJson(String str) => List<MyDocModel>.from(json.decode(str).map((x) => MyDocModel.fromJson(x)));

String myDocModelToJson(List<MyDocModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MyDocModel {
    MyDocModel({
        required this.id,
        required this.name,
        required this.specialist,
        required this.description,
        required this.patients,
        required this.yearExp,
        required this.rating,
        required this.operationalHour,
        required this.hospital,
        required this.thumbnail,
        required this.price,
        required this.isExperience,
    });

    int id;
    String name;
    String specialist;
    String description;
    int patients;
    int yearExp;
    int rating;
    String operationalHour;
    String hospital;
    String thumbnail;
    int price;
    bool isExperience;

    factory MyDocModel.fromJson(Map<String, dynamic> json) => MyDocModel(
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
