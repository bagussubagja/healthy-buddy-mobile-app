// To parse this JSON data, do
//
//     final appointmentScheduleModel = appointmentScheduleModelFromJson(jsonString);

import 'dart:convert';

List<AppointmentScheduleModel> appointmentScheduleModelFromJson(String str) => List<AppointmentScheduleModel>.from(json.decode(str).map((x) => AppointmentScheduleModel.fromJson(x)));

String appointmentScheduleModelToJson(List<AppointmentScheduleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AppointmentScheduleModel {
    AppointmentScheduleModel({
        this.id,
        this.name,
        this.doctorName,
        this.dateAppointment,
        this.hospital,
        this.specialist,
        this.idUser,
        this.mediaType,
        this.thumbnail,
    });

    int? id;
    String? name;
    String? doctorName;
    String? dateAppointment;
    String? hospital;
    String? specialist;
    String? idUser;
    String? mediaType;
    String? thumbnail;

    factory AppointmentScheduleModel.fromJson(Map<String, dynamic> json) => AppointmentScheduleModel(
        id: json["id"],
        name: json["name"],
        doctorName: json["doctor_name"],
        dateAppointment: json["date_appointment"],
        hospital: json["hospital"],
        specialist: json["specialist"],
        idUser: json["id_user"],
        mediaType: json["media_type"],
        thumbnail: json["thumbnail"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "doctor_name": doctorName,
        "date_appointment":dateAppointment,
        "hospital": hospital,
        "specialist": specialist,
        "id_user": idUser,
        "media_type": mediaType,
        "thumbnail": thumbnail,
    };
}
