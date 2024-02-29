// To parse this JSON data, do
//
//     final getNameModel = getNameModelFromJson(jsonString);

import 'dart:convert';

GetNameModel getNameModelFromJson(String str) => GetNameModel.fromJson(json.decode(str));

String getNameModelToJson(GetNameModel data) => json.encode(data.toJson());

class GetNameModel {
  String? statuscode;
  String? status;
  String? message;
  Data? data;

  GetNameModel({
    this.statuscode,
    this.status,
    this.message,
    this.data,
  });

  factory GetNameModel.fromJson(Map<String, dynamic> json) => GetNameModel(
    statuscode: json["statuscode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "statuscode": statuscode,
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  int? id;
  int? bankId;
  String? bankName;
  DateTime? createdAt;

  Data({
    this.id,
    this.bankId,
    this.bankName,
    this.createdAt,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    bankId: json["bank_id"],
    bankName: json["bank_name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bank_id": bankId,
    "bank_name": bankName,
    "created_at": createdAt?.toIso8601String(),
  };
}
