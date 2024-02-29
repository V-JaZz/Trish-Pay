// To parse this JSON data, do
//
//     final getMarginModel = getMarginModelFromJson(jsonString);

import 'dart:convert';

GetMarginModel getMarginModelFromJson(String str) => GetMarginModel.fromJson(json.decode(str));

String getMarginModelToJson(GetMarginModel data) => json.encode(data.toJson());

class GetMarginModel {
  String? status;
  String? message;
  List<Commission>? commission;

  GetMarginModel({
    this.status,
    this.message,
    this.commission,
  });

  factory GetMarginModel.fromJson(Map<String, dynamic> json) => GetMarginModel(
    status: json["status"],
    message: json["message"],
    commission: json["commission"] == null ? [] : List<Commission>.from(json["commission"]!.map((x) => Commission.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "commission": commission == null ? [] : List<dynamic>.from(commission!.map((x) => x.toJson())),
  };
}

class Commission {
  int? id;
  String? type;
  double? whitelable;
  double? md;
  double? distributor;
  double? retailer;
  String? name;
  String? service;
  String? image;

  Commission({
    this.id,
    this.type,
    this.whitelable,
    this.md,
    this.distributor,
    this.retailer,
    this.name,
    this.service,
    this.image,
  });

  factory Commission.fromJson(Map<String, dynamic> json) => Commission(
    id: json["id"],
    type: json["type"],
    whitelable: json["whitelable"]?.toDouble(),
    md: json["md"]?.toDouble(),
    distributor: json["distributor"]?.toDouble(),
    retailer: json["retailer"]?.toDouble(),
    name: json["name"],
    service: json["service"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "whitelable": whitelable,
    "md": md,
    "distributor": distributor,
    "retailer": retailer,
    "name": name,
    "service": service,
    "image": image,
  };
}
