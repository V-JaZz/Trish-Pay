// To parse this JSON data, do
//
//     final aepsBankListModel = aepsBankListModelFromJson(jsonString);

import 'dart:convert';

AepsBankListModel aepsBankListModelFromJson(String str) => AepsBankListModel.fromJson(json.decode(str));
String aepsBankListModelToJson(AepsBankListModel data) => json.encode(data.toJson());

class AepsBankListModel {
  AepsBankListModel({
    this.statuscode,
    this.message,
    this.data,
  });

  String? statuscode;
  String? message;
  List<Datum>? data;

  factory AepsBankListModel.fromJson(Map<String, dynamic> json) => AepsBankListModel(
    statuscode: json["statuscode"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "statuscode": statuscode,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    this.id,
    this.bankId,
    this.bankName,
    this.bankIin,
    this.acquirerCode,
    this.bankCode,
  });

  int? id;
  int? bankId;
  String? bankName;
  String? bankIin;
  String? acquirerCode;
  String? bankCode;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    bankId: json["BankId"],
    bankName: json["BankName"],
    bankIin: json["BankIIN"],
    acquirerCode: json["AcquirerCode"],
    bankCode: json["BankCode"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "BankId": bankId,
    "BankName": bankName,
    "BankIIN": bankIin,
    "AcquirerCode": acquirerCode,
    "BankCode": bankCode,
  };
}
