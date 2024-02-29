// To parse this JSON data, do
//
//     final dmtBankListResponseModel = dmtBankListResponseModelFromJson(jsonString);

import 'dart:convert';

DmtBankListResponseModel dmtBankListResponseModelFromJson(String str) => DmtBankListResponseModel.fromJson(json.decode(str));

String dmtBankListResponseModelToJson(DmtBankListResponseModel data) => json.encode(data.toJson());

class DmtBankListResponseModel {
  DmtBankListResponseModel({
    this.statuscode,
    this.status,
    this.data,
    this.message,
  });

  String? statuscode;
  String? status;
  List<Bank>? data;
  String? message;

  factory DmtBankListResponseModel.fromJson(Map<String, dynamic> json) => DmtBankListResponseModel(
    statuscode: json["statuscode"],
    status: json["status"],
    data: json["data"] == null ? [] : List<Bank>.from(json["data"]!.map((x) => Bank.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "statuscode": statuscode,
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Bank {
  Bank({
    this.id,
    this.bankId,
    this.bankName,
    this.createdAt,
  });

  int? id;
  int? bankId;
  String? bankName;
  DateTime? createdAt;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
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
