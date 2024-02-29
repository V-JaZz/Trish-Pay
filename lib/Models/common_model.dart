// To parse this JSON data, do
//
//     final commonModel = commonModelFromJson(jsonString);

import 'dart:convert';

CommonModel commonModelFromJson(String str) => CommonModel.fromJson(json.decode(str));

String commonModelToJson(CommonModel data) => json.encode(data.toJson());

class CommonModel {
  String? statuscode;
  String? status;
  String? message;

  CommonModel({
    this.statuscode,
    this.status,
    this.message,
  });

  factory CommonModel.fromJson(Map<String, dynamic> json) => CommonModel(
    statuscode: json["statuscode"],
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "statuscode": statuscode,
    "status": status,
    "message": message,
  };
}
