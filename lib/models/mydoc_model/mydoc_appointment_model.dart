// To parse this JSON data, do
//
//     final appointmentScheduleModel = appointmentScheduleModelFromJson(jsonString);

import 'dart:convert';

List<AppointmentScheduleModel> appointmentScheduleModelFromJson(String str) =>
    List<AppointmentScheduleModel>.from(
        json.decode(str).map((x) => AppointmentScheduleModel.fromJson(x)));

String appointmentScheduleModelToJson(List<AppointmentScheduleModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AppointmentScheduleModel {
  AppointmentScheduleModel({
    this.id,
    this.idUser,
    this.idDoctor,
    this.dateAppointment,
    this.media,
    this.idSchedule,
    this.isCompleted,
    this.users,
    this.myDoc,
  });

  int? id;
  String? idUser;
  int? idDoctor;
  String? dateAppointment;
  String? media;
  String? idSchedule;
  bool? isCompleted;
  Users? users;
  MyDoc? myDoc;

  factory AppointmentScheduleModel.fromJson(Map<String, dynamic> json) =>
      AppointmentScheduleModel(
        id: json["id"],
        idUser: json["id_user"],
        idDoctor: json["id_doctor"],
        dateAppointment: json["date_appointment"],
        media: json["media"],
        idSchedule: json["id_schedule"],
        isCompleted: json["isCompleted"],
        users: Users.fromJson(json["users"]),
        myDoc: MyDoc.fromJson(json["my_doc"]),
      );

  Map<String, dynamic> toJson() => {
        "id_user": idUser,
        "id_doctor": idDoctor,
        "date_appointment": dateAppointment,
        "media": media,
        "id_schedule": idSchedule,
      };

  Map<String, dynamic> updateAppointmentStatus() => {
        "isCompleted": isCompleted,
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

class Users {
  Users({
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

  factory Users.fromJson(Map<String, dynamic> json) => Users(
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
        "id": id,
        "id_user": idUser,
        "email": email,
        "name": name,
        "gender": gender,
        "hasDiscount": hasDiscount,
        "balance": balance,
        "address": address,
        "age": age,
        "weight": weight,
        "height": height,
        "daily_activity": dailyActivity,
        "daily_calories": dailyCalories,
      };
}
