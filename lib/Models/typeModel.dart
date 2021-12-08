// To parse this JSON data, do
//
//     final typeModel = typeModelFromJson(jsonString);

import 'dart:convert';

TypeModel typeModelFromJson(String str) => TypeModel.fromJson(json.decode(str));

String typeModelToJson(TypeModel data) => json.encode(data.toJson());

class TypeModel {
  TypeModel({
    required this.status,

    required this.message,
     required      this.data,
  });

  bool status;

  String message;
  List<Datum> data;

  factory TypeModel.fromJson(Map<String, dynamic> json) => TypeModel(
        status: json["status"],

        message: json["message"],
     //  data: json["sjdj"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,

        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.name,
    required this.sort_description,
    required this.sort_order,
    required this.is_active
  });

  String id;
  String name;
  String sort_description;
  String sort_order;
  String is_active;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
    sort_description: json["sort_description"],
    sort_order: json["sort_order"],
    is_active: json["is_active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
