// To parse this JSON data, do
//
//     final getElectricityProductModel = getElectricityProductModelFromJson(jsonString);

import 'dart:convert';

GetElectricityProductModel getElectricityProductModelFromJson(String str) => GetElectricityProductModel.fromJson(json.decode(str));

String getElectricityProductModelToJson(GetElectricityProductModel data) => json.encode(data.toJson());

class GetElectricityProductModel {
  String? status;
  String? message;
  List<Datum>? data;

  GetElectricityProductModel({
    this.status,
    this.message,
    this.data,
  });

  factory GetElectricityProductModel.fromJson(Map<String, dynamic> json) => GetElectricityProductModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  int? id;
  String? name;
  String? type;
  String? status;

  Datum({
    this.id,
    this.name,
    this.type,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "status": status,
  };
}
