// To parse this JSON data, do
//
//     final otpVerifyResponseModel = otpVerifyResponseModelFromJson(jsonString);

import 'dart:convert';

OtpVerifyResponseModel otpVerifyResponseModelFromJson(String str) => OtpVerifyResponseModel.fromJson(json.decode(str));

String otpVerifyResponseModelToJson(OtpVerifyResponseModel data) => json.encode(data.toJson());

class OtpVerifyResponseModel {
  OtpVerifyResponseModel({
    this.status,
    this.message,
    this.apptoken,
    this.userId,
  });

  String? status;
  String? message;
  String? apptoken;
  int? userId;

  factory OtpVerifyResponseModel.fromJson(Map<String, dynamic> json) => OtpVerifyResponseModel(
    status: json["status"],
    message: json["message"],
    apptoken: json["apptoken"],
    userId: json["user_id"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "apptoken": apptoken,
    "user_id": userId,
  };
}