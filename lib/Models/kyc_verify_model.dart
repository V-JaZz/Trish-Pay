// To parse this JSON data, do
//
//     final kycVerifyModel = kycVerifyModelFromJson(jsonString);

import 'dart:convert';

KycVerifyModel kycVerifyModelFromJson(String str) =>
    KycVerifyModel.fromJson(json.decode(str));

String kycVerifyModelToJson(KycVerifyModel data) => json.encode(data.toJson());

class KycVerifyModel {
  String? statuscode;
  String? message;
  String? mobile;
  String? email;
  String? aadhaar;
  String? pan;

  KycVerifyModel({
    this.statuscode,
    this.message,
    this.mobile,
    this.email,
    this.aadhaar,
    this.pan,
  });

  factory KycVerifyModel.fromJson(Map<String, dynamic> json) => KycVerifyModel(
        statuscode: json["statuscode"],
        message: json["message"],
        mobile: json["mobile"],
        email: json["email"],
        aadhaar: json["aadhaar"],
        pan: json["pan"],
      );

  Map<String, dynamic> toJson() => {
        "statuscode": statuscode,
        "message": message,
        "mobile": mobile,
        "email": email,
        "aadhaar": aadhaar,
        "pan": pan,
      };
}
