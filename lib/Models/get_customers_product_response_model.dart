// To parse this JSON data, do
//
//     final getCustomerProductsResponseModel = getCustomerProductsResponseModelFromJson(jsonString);

import 'dart:convert';

GetCustomerProductsResponseModel getCustomerProductsResponseModelFromJson(String str) => GetCustomerProductsResponseModel.fromJson(json.decode(str));

String getCustomerProductsResponseModelToJson(GetCustomerProductsResponseModel data) => json.encode(data.toJson());

class GetCustomerProductsResponseModel {
  GetCustomerProductsResponseModel({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  List<Datum>? data;

  factory GetCustomerProductsResponseModel.fromJson(Map<String, dynamic> json) => GetCustomerProductsResponseModel(
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
  Datum({
    this.id,
    this.name,
    this.type,
    this.status,
  });

  int? id;
  String? name;
  String? type;
  String? status;

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
