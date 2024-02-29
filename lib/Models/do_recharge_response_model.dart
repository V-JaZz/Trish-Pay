// To parse this JSON data, do
//
//     final doRechargeModel = doRechargeModelFromJson(jsonString);

import 'dart:convert';

DoRechargeModel doRechargeModelFromJson(String str) => DoRechargeModel.fromJson(json.decode(str));

String doRechargeModelToJson(DoRechargeModel data) => json.encode(data.toJson());

class DoRechargeModel {
  DoRechargeModel({
    this.status,
    this.payid,
    this.refno,
    this.description,
    this.statuscode,
    this.message,
  });

  String? status;
  String? payid;
  String? refno;
  String? description;
  int? statuscode;
  String? message;

  factory DoRechargeModel.fromJson(Map<String, dynamic> json) => DoRechargeModel(
    status: json["status"],
    payid: json["payid"],
    refno: json["refno"],
    description: json["description"],
    statuscode: json["statuscode"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "payid": payid,
    "refno": refno,
    "description": description,
    "statuscode": statuscode,
    "message": message,
  };
}
