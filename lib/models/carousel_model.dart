// To parse this JSON data, do
//
//     final carouselModel = carouselModelFromJson(jsonString);

import 'dart:convert';

List<CarouselModel> carouselModelFromJson(String str) => List<CarouselModel>.from(json.decode(str).map((x) => CarouselModel.fromJson(x)));

String carouselModelToJson(List<CarouselModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CarouselModel {
    CarouselModel({
        required this.id,
        required this.title,
        required this.description,
        required this.link,
        required this.thumbnail,
        required this.section,
    });

    int id;
    List<String> title;
    List<String> description;
    List<String> link;
    List<String> thumbnail;
    String section;

    factory CarouselModel.fromJson(Map<String, dynamic> json) => CarouselModel(
        id: json["id"],
        title: List<String>.from(json["title"].map((x) => x)),
        description: List<String>.from(json["description"].map((x) => x)),
        link: List<String>.from(json["link"].map((x) => x)),
        thumbnail: List<String>.from(json["thumbnail"].map((x) => x)),
        section: json["section"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": List<dynamic>.from(title.map((x) => x)),
        "description": List<dynamic>.from(description.map((x) => x)),
        "link": List<dynamic>.from(link.map((x) => x)),
        "thumbnail": List<dynamic>.from(thumbnail.map((x) => x)),
        "section": section,
    };
}
