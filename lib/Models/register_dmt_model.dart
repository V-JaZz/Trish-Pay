// To parse this JSON data, do
//
//     final registerDmtResponseModel = registerDmtResponseModelFromJson(jsonString);

import 'dart:convert';

RegisterDmtResponseModel registerDmtResponseModelFromJson(String str) => RegisterDmtResponseModel.fromJson(json.decode(str));

String registerDmtResponseModelToJson(RegisterDmtResponseModel data) => json.encode(data.toJson());

class RegisterDmtResponseModel {
  RegisterDmtResponseModel({
    this.statuscode,
    this.status,
    this.message,
    this.data,
  });

  String? statuscode;
  String? status;
  String? message;
  List<dynamic>? data;

  factory RegisterDmtResponseModel.fromJson(Map<String, dynamic> json) => RegisterDmtResponseModel(
    statuscode: json["statuscode"],
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<dynamic>.from(json["data"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "statuscode": statuscode,
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
  };
}
